Received:  by oss.sgi.com id <S305166AbQDAQw0>;
	Sat, 1 Apr 2000 08:52:26 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:1364 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305164AbQDAQwP>;
	Sat, 1 Apr 2000 08:52:15 -0800
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id IAA25542; Sat, 1 Apr 2000 08:47:34 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA90311
	for linux-list;
	Sat, 1 Apr 2000 08:42:26 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA90007
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 1 Apr 2000 08:42:25 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id IAA22814
	for <linux@cthulhu.engr.sgi.com>; Sat, 1 Apr 2000 08:37:43 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id EC73F7F4; Sat,  1 Apr 2000 18:29:11 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id B4B318FC3; Sat,  1 Apr 2000 18:19:31 +0200 (CEST)
Date:   Sat, 1 Apr 2000 18:19:31 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com
Subject: configure spaghetti code
Message-ID: <20000401181931.M3970@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hi,
i tried to compile my own kernel for the IP22 (mips not mips64) and 
had no sucess (no output on any console) - I think this is due
to the a couple of bugs ...

First of all - The spaghetti code in the config.in contains a lot if nice
gimmicks like:

if [ "$CONFIG_DECSTATION" != "y" ]; then
   source drivers/char/Config.in
else
   mainmenu_option next_comment
   comment 'DECstation Character devices'
[...]
   if [ "$CONFIG_SGI_IP22" = "y" ]; then
      bool 'SGI PROM Console Support' CONFIG_SGI_PROM_CONSOLE
   fi
[...]

Due to this the CONFIG_SGI_PROM_CONSOLE is not even selectable if
i do not enable CONFIG_DECSTATION with CONFIG_SGI_IP22 ...

As most of the Architectures (IP22, Decstation etc) have VERY special
hardware and nothing in common with the "default pc architecture"
wouldnt it be a good way to 

1. Have a choice of ONE architecture to select (Most of them can coexist
   within the same kernel)
2. Depending on the selected Architecture include "config" scripts
   within their special directory (Probably common CPU Type and networking
   option, filesystem selection)
3. Only show devices which are really available for the architectures
   (I dont think anyone has succeeded in plugging a 3C509 into a DecStation 
   5000 or a Telephony card or even IDE)

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
