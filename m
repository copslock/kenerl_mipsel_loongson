Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 May 2009 19:25:52 +0100 (BST)
Received: from ey-out-1920.google.com ([74.125.78.144]:12800 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024164AbZEaSZp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 31 May 2009 19:25:45 +0100
Received: by ey-out-1920.google.com with SMTP id 4so302959eyg.54
        for <multiple recipients>; Sun, 31 May 2009 11:25:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=3xhzEM29PbDbG5EDVFnkEBullzmnYYN6jwDGy1TZS88=;
        b=aWS3w4PloOFkQWCPLS3Jk8IPk4n7Z0QYTeho8GGlMvNutVaZhOBYYaF1DcTLuZktUp
         rUU89eb1FTi3gGfydB4xTZ4x5z285c5tERB/Bvo36Gx+e94tc2GkirQLFZkg1Ih1Bor0
         IVKMSSxFTOzxGtYJ30mnnz9xEH2eK/IgjHtUs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=dnmUHMpfGceewbaPk53MFhf2XnvtYNaCzQSvVBwMXGrOZvJ2DbFVqyLIeNxJYy3oSA
         5DtX8Gw8mC+3eI+73zFhhkixVTAKmEGp1QsCtkprSm37UY2rQDDf94pr8v2+O03cCC06
         eRXpO3R1f057/S5W0QWSLNmseDH6XzlgePVyQ=
Received: by 10.210.141.19 with SMTP id o19mr5047482ebd.54.1243794343771;
        Sun, 31 May 2009 11:25:43 -0700 (PDT)
Received: from ?192.168.1.20? (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 5sm6217776eyf.28.2009.05.31.11.25.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 May 2009 11:25:43 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 0/10] Updated bcm63xx support
Date:	Sun, 31 May 2009 20:25:38 +0200
User-Agent: KMail/1.9.9
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200905312025.39799.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23089
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Ralf, Maxime,

The following patch series updates the linux-bcm63xx tree with
the following changes :

1: use gpiolib instead of the old GENERIC_GPIO API
2 and 3: add new board definitions that OpenWrt users have been able to run a 
kernel on
4: register a fallback SPROM for b43 to work
5 and 6: fix two variables that were not correctly zero initialized (from 
Maxime)
7 : fix typo in the CPU frequency print
8 : update defconfig with gpiolib support
9 : enable SSB support in the defconfig
10: fix compilation failure of the Ethernet MAC driver

Thanks.
-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
