Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jan 2004 20:44:46 +0000 (GMT)
Received: from mail.e-smith.com ([IPv6:::ffff:216.191.234.126]:12295 "HELO
	nssg.mitel.com") by linux-mips.org with SMTP id <S8225223AbUAGUon>;
	Wed, 7 Jan 2004 20:44:43 +0000
Received: (qmail 16703 invoked by uid 404); 7 Jan 2004 20:44:33 -0000
Received: from charlieb-linux-mips@e-smith.com by tripe.nssg.mitel.com with qmail-scanner; 07 Jan 2004 15:44:33 -0000
Received: from allspice-core.nssg.mitel.com (HELO e-smith.com) (10.33.16.12)
  by tripe.nssg.mitel.com (10.33.17.11) with SMTP; 07 Jan 2004 20:44:33 -0000
Received: (qmail 7373 invoked by uid 5008); 7 Jan 2004 20:44:32 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Jan 2004 20:44:32 -0000
Date: Wed, 7 Jan 2004 15:44:32 -0500 (EST)
From: Charlie Brady <charlieb-linux-mips@e-smith.com>
X-X-Sender: charlieb@allspice.nssg.mitel.com
To: Dimitri Torfs <dimitri@sonycom.com>
cc: linux-mips@linux-mips.org
Subject: Re: [PATCH][2.6] Fix Makefiles for CONFIG_EMBEDDED_RAMDISK
In-Reply-To: <20040106205758.GA19525@sonycom.com>
Message-ID: <Pine.LNX.4.44.0401071543430.1954-100000@allspice.nssg.mitel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <charlieb-linux-mips@e-smith.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3879
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: charlieb-linux-mips@e-smith.com
Precedence: bulk
X-list: linux-mips


On Tue, 6 Jan 2004, Dimitri Torfs wrote:

>   here are patches that fix the arch/mips/Makefile and
>   arch/mips/ramdisk/Makefile when an embedded ramdisk image needs to
>   be included through the CONFIG_EMBEDDED_RAMDISK option.

I'm curious as to why this is a mips specific feature. Does anyone know?

--
Charlie
