Received:  by oss.sgi.com id <S553775AbQJTHp7>;
	Fri, 20 Oct 2000 00:45:59 -0700
Received: from widukind.bi.teuto.net ([212.8.197.28]:59399 "EHLO
        widukind.bi.teuto.net") by oss.sgi.com with ESMTP
	id <S553770AbQJTHph>; Fri, 20 Oct 2000 00:45:37 -0700
Received: from micropolis.microdata-pos.de ([212.8.203.34])
	by widukind.bi.teuto.net (8.9.3/8.9.3) with ESMTP id JAA20869
	for <linux-mips@oss.sgi.com>; Fri, 20 Oct 2000 09:45:34 +0200
Received: from imail.microdata-pos.de 
	by micropolis.microdata-pos.de (8.9.3/8.9.3/Debian/GNU) with ESMTP id JAA19189
	for <linux-mips@oss.sgi.com>; Fri, 20 Oct 2000 09:45:33 +0200
Received: 
	by imail.microdata-pos.de (8.9.3/8.9.3/Debian 8.9.3-21) id JAA09368
	for linux-mips@oss.sgi.com; Fri, 20 Oct 2000 09:45:03 +0200
Date:   Fri, 20 Oct 2000 09:45:03 +0200
From:   Jan-Benedict Glaw <jbglaw@microdata-pos.de>
To:     linux-mips@oss.sgi.com
Subject: whiptail and debconf
Message-ID: <20001020094503.A9179@microdata-pos.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi!

/*
 *	My regular provider seems to be down right now,
 *	so I've to use this email address;(
 */

Well, I've now got a chroot[1]-environment with quite most of all
important packages installed the correct and ight way (TM). However,
some of them fail because neither whiptail nor one of the debconf
variants is available. I've not yet a native compiler; could someone
*please* try to build a .deb of these packages?

MfG, JBG
[1] chroot seems to be little bit buggy to me in the declinux root fs...

    root@localhost#> chroot base_tgz_dir/ /bin/bash

    ...results in "cwd: Can't get current path" (from memory). Doing
    a "ls" shows base_tgz_dir (and other directory entries) which
    should no longer be available nor visible to the process!
    chdir()ing into base_tgz_dir manually after doing the chroot
    command fixes that, but that's a bit confusing to me...

-- 
My ~/.sig is on another host;(
