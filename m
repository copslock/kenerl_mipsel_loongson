Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id UAA11302 for <linux-archive@neteng.engr.sgi.com>; Sun, 12 Jul 1998 20:32:31 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA59294
	for linux-list;
	Sun, 12 Jul 1998 20:31:56 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from dataserv.detroit.sgi.com (dataserv.detroit.sgi.com [169.238.128.2])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id UAA96066
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 12 Jul 1998 20:31:53 -0700 (PDT)
	mail_from (eak@detroit.sgi.com)
Received: from cygnus.detroit.sgi.com by dataserv.detroit.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1502/930416.SGI)
	 id XAA18513; Sun, 12 Jul 1998 23:31:51 -0400
Received: from detroit.sgi.com (cx1.detroit.sgi.com [169.238.130.4]) by cygnus.detroit.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id XAA10405; Sun, 12 Jul 1998 23:31:49 -0400 (EDT)
Message-ID: <35A97E51.16F98B05@detroit.sgi.com>
Date: Sun, 12 Jul 1998 23:26:09 -0400
From: Eric Kimminau <eak@detroit.sgi.com>
Reply-To: eak@detroit.sgi.com
Organization: Silicon Graphics, Inc
X-Mailer: Mozilla 4.09C-SGI [en] (X11; I; IRIX 6.2 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC: linux@cthulhu.engr.sgi.com
Subject: Re: Indy serial ports
References: <19980712145324.03216@alpha.franken.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thomas Bogendoerfer wrote:
> 
> Hi,
> 
> I'm about to start converting the SGI console to a abscon style console.
> To make debugging easier I'm planning to use a serial console. But my
> Indy doesn't have any "normal" serial connector. I guess the two serial
> ports are those PS/2 connectors near the mouse and keyboard connectors.
> As I don't have an converter I need the pinout of the PS/2 connectors
> to build my own one. Any hints where I can find a description of that
> ports ?
> 
> Thomas.

>From the IRIX 'man serial' man page:

     The DIN-8 serial port connectors on the Personal IRIS 4D/30,
4D/35,
     4D/RPC (Indigo), 4D/RPC-50 (R4000 Indigo), Indy, and Indigo2 have
the
     following pin assignments.

                                                                       
Page 2

serial(7)                                                           
serial(7)

                                     ---------
                                    / 8  7  6 \
                                   (  5  4  3  )
                                    \  2   1  /

--                                      ---------

                      4D Compatible Pin Assignments (RS-232)
                     _________________________________________
                     _Pin___|_Name____|_Description___________
                       1    | DTR     | Data Terminal Ready
                       2    | CTS     | Clear To Send
                       3    | TD      | Transmit Data
                       4    | SG      | Signal Ground
                       5    | RD      | Receive Data
                       6    | RTS     | Request To Send
                       7    | DCD     | Data Carrier Detect
                       8    | SG      | Signal Ground

                 Macintosh SE Compatible Pin Assignments (RS-422)
                 _________________________________________________
                 Pin__|_Name__|_Description_______________________
                  1   | HSKo  | Output Handshake
                  2   | HSKi  | Input Handshake Or External Clock
                  3   | TxD-  | Transmit Data -
                  4   | GND   | Signal Ground
                  5   | RxD-  | Receive Data -
                  6   | TxD+  | Transmit Data +
                  7   | GPi   | General Purpose Input
                  8   | RxD+  | Receive Data +

     The set of signals that are actually used depends upon which form
of the
     device was opened.  If the ttyd name was used, only TD, RD, and
SG
     signals are meaningful.  These three signals are typically used
with
     "dumb" devices that either do not need any sort of data flow
control or
     use software flow control (see the description of the ixon,
ixany, and
     ixoff options in stty(1) for more information on setting up
software flow
     control).  If the ttym device is used, the DCD, and DTR signals
are also
     used.  These signals provide a two way handshake for establishing
and
     breaking a communication link with another device and are
normally used
     when connecting via a modem.  When the port is initially opened,
the host
     asserts the DTR line and waits for the DCD line to become
active.  If the
     port is opened with the O_NDELAY flag, the open succeeds even if
the DCD
     line is not active.  A hangup condition occurs if the DCD line
     transitions from active to inactive.  See open(2), and termio(7)
for more
     information.  If the ttyf device is used, all of the signals are
used.
     The additional signals provide for full hardware flow control
between the
     host and the remote device.  The RTS line is asserted by the host
     whenever it is capable of receiving more data.  The CTS line is
sampled
     before data is transmitted and if it is not active, the host
suspends
     output until it is.

                                                                       
Page 3

serial(7)                                                           
serial(7)

     The DIN-8 serial port connectors on the Personal IRIS 4D/30,
4D/35,
     4D/RPC, 4D/RPC-50, Indy, and Indigo2 can be used to communicate
with
     serial devices using RS-422 protocol.  User can use the stream
ioctl
     commands, SIOC_EXTCLK and SIOC_RS422, defined in
/usr/include/sys/z8530.h
     to switch between internal/external clock and RS-232/RS-422
protocols.
     Another command that can be useful is SIOC_ITIMER; it informs the
driver
     how long it should buffer up input data, in clock ticks, before
sending
     them upstream.  Data can sometimes be sent upstream before, but
never
     after, this time limit.  This feature reduces the cpu cost of
receiving
     large amounts of data by sending data upstream in large chunks. 
This
     duration can also be configured into the kernel by tuning the
     duart_rsrv_duration variable.
...
FILES
     /dev/tty[dmf][1-4,45-56]
     /usr/include/sys/z8530.h
     /dev/MAKEDEV

                                                                       
Page 4

serial(7)                                                           
serial(7)

serial(7)                                                           
serial(7)

     /var/sysgen/system

SEE ALSO
     system(4), asoser(7), cdsio(7), keyboard(7), streamio(7),
termio(7).

---------1---------2---------3---------4---------5---------6---------7
Eric Kimminau                           RTA/RSA
eak@detroit.sgi.com                     Silicon Graphics, Inc
Voice: (248) 848-4455                   39001 West 12 Mile Rd.
Fax:   (248) 848-5600                   Farmington, MI 48331-2903

                 VNet Extension - 6-327-4455
              "I speak my mind and no one else's."
       http://www.dcs.ex.ac.uk/~aba/rsa/perl-rsa-sig.html

    When confronted by a difficult problem, solve it by reducing 
    it to the question, "How would the Lone Ranger handle this?"
	
         "I am the great supportfolio, do you have http?"

        Copyright 1998, Silicon Graphics Computer Systems
        Confidential to Silicon Graphics Computer Systems
                ** -- not for redistribution -- **
