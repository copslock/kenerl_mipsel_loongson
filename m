Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Mar 2010 23:36:21 +0100 (CET)
Received: from mail-bw0-f226.google.com ([209.85.218.226]:39727 "EHLO
        mail-bw0-f226.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492006Ab0CAWgS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Mar 2010 23:36:18 +0100
Received: by bwz26 with SMTP id 26so2428417bwz.27
        for <multiple recipients>; Mon, 01 Mar 2010 14:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :x-uid:x-length:to:reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=ck3Pkj6IVakE0a6mFqo8Mar82YUcpwOZErBdkRFSbsY=;
        b=TPPdcdtt2UpwDxmmYAi2IZizAIurDdkQqEdaJsV285j0SBrpVGQes5lmaVsJvTb2/I
         4dPnyjPKPhHII8bj2+qYuAnhgzux2jxEGuhPmIMVWACEuU69PTIxtV4x4cojQYdnm7u7
         QjnZ70kNLvkjrBSM/DeEMpm8qhKmWAG4kMC+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:x-uid:x-length:to:reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        b=vAvFmrzuk/DaF/pAqrQStWoPHUS6XVo4Z+QoS/NvRFTGQ+hIzFrZnNTU55kCvSG9YZ
         X6BbXFZp7FhbvQ2yTk5/P6g8cNrGSbeymkqueDXj84uphCSIcVDAw49LhIJeaS+s+How
         pQ3fqyK6yqHXZgJ5RInRX4TDw9SlqvqF/99bA=
Received: by 10.204.32.146 with SMTP id c18mr3553766bkd.185.1267482970851;
        Mon, 01 Mar 2010 14:36:10 -0800 (PST)
Received: from lenovo.localnet (153.44.69-86.rev.gaoland.net [86.69.44.153])
        by mx.google.com with ESMTPS id e18sm1094063bkd.5.2010.03.01.14.36.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Mar 2010 14:36:10 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Date:   Mon, 1 Mar 2010 23:36:07 +0100
Subject: [PATCH 0/4] bcm63xx: misc fixes and new boards
X-UID:  171
X-Length: 516
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Reply-To: Florian Fainelli <florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201003012336.08213.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26079
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Ralf,

These are some misc fixes and two new board definitions applying on top of 
Maxime's series:

bcm63xx updates for 2.6.34 and bcm63xx_uart updates for 2.6.34

Florian Fainelli (4):
  bcm63xx: fix tabs vs spaces in board_bcm963xx.c
  bcm63xx: add rta1025w_16 board
  bcm63xx: add DWVS0 board
  bcm63xx: fix BCM6338 and BCM6345 gpio count

Thanks!
