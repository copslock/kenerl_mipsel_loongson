Received:  by oss.sgi.com id <S554054AbRAQO1l>;
	Wed, 17 Jan 2001 06:27:41 -0800
Received: from mx.mips.com ([206.31.31.226]:12499 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S554051AbRAQO11>;
	Wed, 17 Jan 2001 06:27:27 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id GAA08654
	for <linux-mips@oss.sgi.com>; Wed, 17 Jan 2001 06:27:21 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id GAA27781
	for <linux-mips@oss.sgi.com>; Wed, 17 Jan 2001 06:27:20 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id PAA26443
	for <linux-mips@oss.sgi.com>; Wed, 17 Jan 2001 15:26:39 +0100 (MET)
Message-ID: <3A65AB9E.D98F895C@mips.com>
Date:   Wed, 17 Jan 2001 15:26:38 +0100
From:   Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: Can't activate swap partitions
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

When I try to activate swap partitions, I get the following:
Swap area shorter than signature indicates
swapon: /dev/hda2: Invalid argument

Note: that I'm running with a 64 bit kernel on a 32 bit userland.
It works fine with a 32 bit kernel.

Have anyone seen this before ?

/Carsten


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
