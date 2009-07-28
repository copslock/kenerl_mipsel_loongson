Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jul 2009 23:00:30 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:57695 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493676AbZG1VAX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Jul 2009 23:00:23 +0200
Received: by ewy12 with SMTP id 12so62414ewy.0
        for <multiple recipients>; Tue, 28 Jul 2009 14:00:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=7TTij6OOXc6XBtT8mAyxxvID0ohsyh0oYKVNd8RXejg=;
        b=xYvf4rtah2NmMJUi5YtjpVDoQVdNvnw/Klja4vP5Ac8FjIWwDKgdYam8mBDV2xYyZQ
         5gSDq6QPiVwHDwuS2zQuyaIYGQdzgTVFd2mnn6fVWfxkHYd5+8DDAVlums9neDrFpK3+
         I0dygcrHt1WVsoVnzdzp/dAGezHneTo0y4/2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=DcBAcki+79j6iG0R/DUKiLkGhAlMSy2GonouH5js+pkogMlfuapoostXlLW3qkRk5c
         BpdoywBzccHnNqv0C9OWQG/Hnw4YAQwnqtDjB3wE2dENu6fHKXiEXq2aDS5XLqN+CYY5
         zvcjrkaeN3ulJj9gbmx/vxqafgtQYMibVbdDM=
Received: by 10.210.130.13 with SMTP id c13mr7024930ebd.0.1248814817021;
        Tue, 28 Jul 2009 14:00:17 -0700 (PDT)
Received: from ?192.168.254.2? (florian.mimichou.net [82.241.112.26])
        by mx.google.com with ESMTPS id 24sm573321eyx.23.2009.07.28.14.00.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Jul 2009 14:00:16 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 0/4] au1000_eth platform device/driver conversion
Date:	Tue, 28 Jul 2009 23:00:04 +0200
User-Agent: KMail/1.9.9
Cc:	Manuel Lauss <manuel.lauss@googlemail.com>,
	David Miller <davem@davemloft.net>, linux-mips@linux-mips.org,
	netdev@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200907282300.07144.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23785
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Ralf, David, Manuel,

The following patches convert the AMD Alchemy au1000_eth driver
to become a platform device/driver. The patches are splitted that way:

PATCH 1: set up the infrastructure in the board code to register au1000_eth as
as platform device.
PATCH 2: convert au1000_eth to become a real platform driver
PATCH 3: add infrastructure to pass PHY informations to the au1000_eth driver
PATCH 4: use those platform_data PHY informations in the au1000_eth driver

The result is a driver which is equally functionnal with no platform-related ifdefs
aiming towards easier integration of the upcoming Alchemy 1300 SoC. The conversion
was made in two times to ease code review as the driver was a real ifdef mess prior
to these changes.

David, on top of this series I send driver cleanups.

Thanks !
-- 
Best regards, Florian Fainelli
Email: florian@openwrt.org
Web: http://openwrt.org
IRC: [florian] on irc.freenode.net
-------------------------------
