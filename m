Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Dec 2007 15:34:18 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.174]:62763 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20032395AbXLWPeI (ORCPT <rfc822;linux-mips@ftp.linux-mips.org>);
	Sun, 23 Dec 2007 15:34:08 +0000
Received: by ug-out-1314.google.com with SMTP id k3so959198ugf.38
        for <linux-mips@ftp.linux-mips.org>; Sun, 23 Dec 2007 07:33:58 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=X9rNmo/KJE+WXaUbO8kAiZ0SpM045qO0BEym7UezwcA=;
        b=F4QiUT3CczpjUShjQ6hyWtXUnvjdqRDVGGisQIIS/cuD1f/on0LPn4qM8dgagOOEFCrHlXDkD0jfGM7/Dp2L9F0kZNfYmK2LGeS+GrBppf531pLBGrOuGJzyRWhVE8EpGv8ZImsgIfHWOzmA3XJzyoSN+ltW7FIkQwNMLs5WS7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iyWso7E2Zd91rHU5FEqHyqRTTmNbo37IUbqKKuNkAB7DYrE6itIOhqEQXXCuhcvU5LHKhmhmNEXDFzdVukwTO72fTRahp+HrqNrsdem9pmErqHVvOvpRTNqXYzL2Mg7Fl78tU1suwfIykcdE8wev/S65By+KQ2MLJnw3eBllFbY=
Received: by 10.66.220.17 with SMTP id s17mr2198295ugg.20.1198424038068;
        Sun, 23 Dec 2007 07:33:58 -0800 (PST)
Received: by 10.67.117.17 with HTTP; Sun, 23 Dec 2007 07:33:58 -0800 (PST)
Message-ID: <9e0cf0bf0712230733o3dfd54fcp4962ebf3f84cdff@mail.gmail.com>
Date:	Sun, 23 Dec 2007 17:33:58 +0200
From:	"Alon Bar-Lev" <alon.barlev@gmail.com>
To:	linux-mips@ftp.linux-mips.org, LKML <linux-kernel@vger.kernel.org>
Subject: [MIPS] MEM_SDREFCFG is not defined for Alchemy DB1550 (compile fail)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <alon.barlev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@ftp.linux-mips.org
Original-Recipient: rfc822;linux-mips@ftp.linux-mips.org
X-archive-position: 17871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alon.barlev@gmail.com
Precedence: bulk
X-list: linux-mips

Hello,

When I have:
CONFIG_MIPS_DB1550
CONFIG_SOC_AU1550
CONFIG_SOC_AU1X00
CONFIG_PM

MEM_SDREFCFG is used at:
arch/mips/au1000/common/power.c::pm_do_freq()

While the MEM_SDREFCFG constant is declare only for CONFIG_SOC_AU1000,
CONFIG_SOC_AU1500, CONFIG_SOC_AU1100 at:
include/asm-mips/mach-au1x00/au1000.h

Maybe MEM_SDREFCFG should be defined for CONFIG_SOC_AU1X00?
Or there should be #ifdef for its usage in power.c?

Best Regards,
Alon Bar-Lev.
