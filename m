Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id VAA95704 for <linux-archive@neteng.engr.sgi.com>; Sun, 3 Jan 1999 21:37:44 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id VAA84674
	for linux-list;
	Sun, 3 Jan 1999 21:36:42 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.42.13])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id VAA45850
	for <linux@engr.sgi.com>;
	Sun, 3 Jan 1999 21:36:40 -0800 (PST)
	mail_from (ariel@oz.engr.sgi.com)
Received: (from ariel@localhost) by oz.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) id VAA52870 for linux@engr.sgi.com; Sun, 3 Jan 1999 21:36:40 -0800 (PST)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199901040536.VAA52870@oz.engr.sgi.com>
Subject: [fwd] Re: SGI Linux HardHat 5.1 Install problems
To: linux@cthulhu.engr.sgi.com (SGI/Linux mailing list)
Date: Sun, 3 Jan 1999 21:36:39 -0800 (PST)
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

[Forwarding bounced message from: "[Eazy|E]" <sniper@kibla.org>
 which isn't apparently subscribed with this exact address.]


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> Alright.  The first thing is that it can't possibly be an R3000 CPU, it's
> an R4x00 or R5000.
Oppps, my bad, it's:

System : IP22
Processor: 100 Mhz R4600 with FPU
> 
> The 'unable to open console' means that the kernel doesn't have access to
> a root filesystem; that's likely a problem with your NFS server. 
> 
> How do you have your root install fs exported?

/etc/exports looks that way :

/usr/SGILinux   192.168.1.2 (no_root_squash, rw)

And this is what dir /usr/SGILinux contains:
[SU-root@sniper:/usr/SGILinux]# ls
COPYING    RedHat     doc        lib        modules    usr
CREDITS    TRANS.TBL  dosutils   linuxrc    proc       var
PGP_KEY    bin        etc        misc       sbin       vmlinux
README     dev        images     mnt        tmp
[SU-root@sniper:/usr/SGILinux]#


I dunno, it prolly wants to run linuxrc which is simb. linked to
sbin/initrd, but why doesnt it work ?

Thanks in advance, Later.

- --
 .---|=====| [eD-EPiC]&[eD] |======|---.
 |  [Eazy|E] @ IRCNET,EFNET,TAIN       |  |=| WoRD of ThE DaY -> [eD] <- |=|
 |  e-mail: sniper@kibla.org           |     ||   ->SpREAD ThE WoRD<-   ||
 `---|=====|   Rogue Core   |======|---'

-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 5.0i for non-commercial use
Charset: noconv

iQA/AwUBNpARNK6mKYH+3vCKEQLMmwCdFm1GswcPEz1WTuzBmUSSdy0s+xQAn1wF
yPm2w5QqyHACzCakJdAKufkM
=zOwV
-----END PGP SIGNATURE-----


-- 
Peace, Ariel
