Received:  by oss.sgi.com id <S305173AbQCALqu>;
	Wed, 1 Mar 2000 03:46:50 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:39251 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305163AbQCALqp>;
	Wed, 1 Mar 2000 03:46:45 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id DAA24198; Wed, 1 Mar 2000 03:42:10 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA39450
	for linux-list;
	Wed, 1 Mar 2000 03:36:14 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA91985
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 1 Mar 2000 03:36:11 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA09371
	for <linux@cthulhu.engr.sgi.com>; Wed, 1 Mar 2000 03:36:02 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 8FF137F5; Wed,  1 Mar 2000 12:36:01 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 372EF8FC3; Wed,  1 Mar 2000 12:23:29 +0100 (CET)
Date:   Wed, 1 Mar 2000 12:23:29 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: 2.3.47 success on Decstation 5000/150, problems with login
Message-ID: <20000301122329.B4608@paradigm.rfc822.org>
References: <20000301115053.A4608@paradigm.rfc822.org> <Pine.GSO.4.10.10003011222500.13477-100000@dandelion.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <Pine.GSO.4.10.10003011222500.13477-100000@dandelion.sonytel.be>; from Geert Uytterhoeven on Wed, Mar 01, 2000 at 12:25:02PM +0100
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, Mar 01, 2000 at 12:25:02PM +0100, Geert Uytterhoeven wrote:
> 
> What does `ssh -v root@repeat.rfc822.org' say?

(flo@ping)~# ssh -v root@repeat.rfc822.org 
SSH Version 1.2.26 [i586-unknown-linux], protocol version 1.5.
Standard version.  Does not use RSAREF.
ping: Reading configuration data /etc/ssh/ssh_config
ping: ssh_connect: getuid 1000 geteuid 0 anon 0
ping: Connecting to repeat.rfc822.org [193.189.250.44] port 22.
ping: Allocated local port 1021.
ping: Connection established.
ping: Remote protocol version 1.5, remote software version 1.2.27
ping: Waiting for server public key.
ping: Received server public key (768 bits) and host key (1024 bits).
ping: Host 'repeat.rfc822.org' is known and matches the host key.
ping: Initializing random; seed file /home/flo/.ssh/random_seed
ping: Encryption type: idea
ping: Sent encrypted session key.
ping: Installing crc compensation attack detector.
ping: Received encrypted confirmation.
ping: Trying rhosts or /etc/hosts.equiv with RSA host authentication.
ping: Server refused our rhosts authentication or host key.
ping: Connection to authentication agent opened.
ping: RSA authentication using agent refused.
ping: Trying RSA authentication with key 'flo@move'
ping: Server refused our key.
ping: Doing password authentication.
root@repeat.rfc822.org's password: 
ping: Requesting pty.
ping: Requesting X11 forwarding with authentication spoofing.
ping: Remote: Client requested X11 forwarding, but the server has no xauth program.
ping: Remote: This is usually caused by "xauth" not being in PATH during compile.
Warning: Remote host denied X11 forwarding, perhaps xauth program could not be run on the server side.
ping: Requesting authentication agent forwarding.
ping: Requesting shell.
ping: Entering interactive session.
Connection to repeat.rfc822.org closed by remote host.
Connection to repeat.rfc822.org closed.
ping: Transferred: stdin 0, stdout 0, stderr 97 bytes in 0.2 seconds
ping: Bytes per second: stdin 0.0, stdout 0.0, stderr 392.2
ping: Exit status -1

> BTW, does this mean you have a Debian/mipsel ssh package now?

ftp.rfc822.org

/pub/local/debian/debian-non-US/dists/potato/non-US/non-free/binary-mipsel/ssh_1.2.27-2_mipsel.deb

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
