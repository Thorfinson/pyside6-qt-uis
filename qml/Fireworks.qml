import QtQuick 6
import QtQuick.Window 2.15
import QtQuick.Controls 6
import QtQuick.Controls.Material 2.15
import QtQuick.Particles 2.15

// Fireworks definition - mostly taken from https://qmlbook.github.io/ch10-particles/particles.html#particle-groups
Rectangle {
    property int emittedRockets: 30

    // main particle system
    ParticleSystem {id: particlesSystem}

    // firework emitter
    Emitter {
    id: fireWorkEmitter
    system: particlesSystem
    enabled: true
    lifeSpan: 1750
    maximumEmitted: emittedRockets
    group: "Fire"
    // we want to emit particles
    // from the bottom of the window
    anchors{
        left: parent.left
        right: parent.right
        bottom: parent.bottom
    }
    // velocity for the rockets
    velocity:  AngleDirection {
                angle: 270
                angleVariation: 10
                magnitude: 200
            }
    // Define the exploding particle Goal
    GroupGoal {
        // on which group to apply
        groups: ["Fire"]
        // the goalState
        goalState: "exploding"
        system: particlesSystem
        // switch once the particles reach the window center
        y: - root.height / 2
        width: parent.width
        height: 10
        // make the particles immediately move to the goal state
        jump: true
    }
    // Set the particle image
    ImageParticle {
        source: "../resources/particle.png"
        system: particlesSystem
        color: "red"
        groups: ["Fire"]
    }
    }
    // Smoke Trail Emitter
    TrailEmitter {
    system: particlesSystem
    group: "Smoke"
    // follow another particle
    follow: "Fire"
    size: 12
    emitRatePerParticle: 20
    velocity: PointDirection {yVariation: 10; xVariation: 10}
    acceleration: PointDirection {y:  10}
    ImageParticle {
        source: "../resources/particle.png"
        system: particlesSystem
        groups: ["Smoke"]
        color: "white"
    }
    }
    ParticleGroup {
    name: "exploding"
    system: particlesSystem
        TrailEmitter {
            group: "Particles"
            enabled: true
            anchors.fill: parent
            lifeSpan: 2000
            emitRatePerParticle: 500
            size: 8
            velocity: AngleDirection {angleVariation: 360; magnitude: 200; magnitudeVariation: 50}
            acceleration: PointDirection {y: 150}
            ImageParticle {
                source: "../resources/particle.png"
                system: particlesSystem
                groups: ["Particles"]
                color: "red"
                colorVariation: 1.2
            }
        }
    }
}