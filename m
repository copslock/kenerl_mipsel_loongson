Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Aug 2009 23:46:32 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:52655 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492923AbZHGVq0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Aug 2009 23:46:26 +0200
Received: by ewy12 with SMTP id 12so2282279ewy.0
        for <multiple recipients>; Fri, 07 Aug 2009 14:46:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=uExFJFgfv1E5EXxJF1zDj6iUSKGubglgj+mAs0VVURA=;
        b=TIU7bJcuLshZCgG+wRCo2uwDm7y4Quie1jRi1bjwuAMercqx1zVyjjn0md0YoFkW9u
         9i2T3Gzja5Whhh4Seq5xu+sh9U13Z4nMdM2z7VRtMcgMgQX4fVXTbpOmgf11WandXNh2
         Eltar5YsZIG6Qn4lJ4PBBGyMZ0jFCnNI13lRA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=VdDTrqXb/wC83u/Xdr3ZjbFpWB4AVak7cMF9PR5htuPdtyeIewQUheM7TJB19c7/OJ
         wypNb0Z7RwntFUVlZLjgcQDiJIF5GblPdb1d/yM9bVpZh57lqVb19f/TBSlUnwEsViNV
         SOe2dXIVIOHzI80x2ssM5lQtAvAHRh9bGupGM=
Received: by 10.210.81.9 with SMTP id e9mr25549ebb.68.1249681578421;
        Fri, 07 Aug 2009 14:46:18 -0700 (PDT)
Received: from lenovo.mimichou.home (home.mimichou.net [82.67.132.19])
        by mx.google.com with ESMTPS id 28sm1543080eye.24.2009.08.07.14.46.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Aug 2009 14:46:18 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 0/8] New BCM63xx SoC support and devices registration
Date:	Fri, 7 Aug 2009 23:46:14 +0200
User-Agent: KMail/1.9.9
Cc:	Maxime Bizon <mbizon@freebox.fr>, linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908072346.15278.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23852
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Ralf, Maxime,

The following 8 patches apply on top of the patch entitled "bcm63xx: fix build 
failures when CONFIG_PCI is disabled"

Ralf, Maxime sent a patch series on June 3rd which would be great to merge so 
that I can rebase my serie on that one.

Thanks and have a nice weekend.
-- 
Best regards, Florian Fainelli
Email: florian@openwrt.org
Web: http://openwrt.org
IRC: [florian] on irc.freenode.net
-------------------------------
