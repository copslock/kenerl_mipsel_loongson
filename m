Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Feb 2011 09:27:11 +0100 (CET)
Received: from cpsmtp-fia02.kpnxchange.com ([195.121.247.5]:1207 "EHLO
        cpsmtp-fia02.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491177Ab1BNI1I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Feb 2011 09:27:08 +0100
Received: from mouse.matrix.dare.nl ([217.166.125.17]) by cpsmtp-fia02.kpnxchange.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 14 Feb 2011 09:26:58 +0100
Received: from localhost (localhost [127.0.0.1])
        by mouse.matrix.dare.nl (Postfix) with ESMTP id 34363AA1F8
        for <linux-mips@linux-mips.org>; Mon, 14 Feb 2011 09:26:53 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at dare.nl
Received: from mouse.matrix.dare.nl ([127.0.0.1])
        by localhost (mouse.matrix.dare.nl [127.0.0.1]) (amavisd-new, port 10024)
        with SMTP id Q6FSrSCeeaDg for <linux-mips@linux-mips.org>;
        Mon, 14 Feb 2011 09:26:44 +0100 (CET)
Received: from [192.168.8.199] (id6721.matrix.dare.nl [192.168.8.199])
        by mouse.matrix.dare.nl (Postfix) with ESMTP id 834BAAA1DF
        for <linux-mips@linux-mips.org>; Mon, 14 Feb 2011 09:26:44 +0100 (CET)
Message-ID: <4D58E745.9090003@dare.nl>
Date:   Mon, 14 Feb 2011 09:26:45 +0100
From:   Robert Bon <robo@dare.nl>
Organization: D.A.R.E!! Development
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
MIME-Version: 1.0
To:     linux-mips <linux-mips@linux-mips.org>
Subject: alchemy au1100 where is the MMC card
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Feb 2011 08:26:58.0357 (UTC) FILETIME=[F222AE50:01CBCC20]
Return-Path: <robo@dare.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robo@dare.nl
Precedence: bulk
X-list: linux-mips

Hello,

Kernel 2.6.37
Where is the support for a MMC card for the Alchemy AU1100 processor?
Is is only supported  for the AU1200?

See file: "drivers/mmc/host/Kconfig
config MMC_AU1X
   tristate "Alchemy AU1XX0 MMC Card Interface support"
   depends on SOC_AU1200


Robert Bon



__________ Information from ESET NOD32 Antivirus, version of virus signature database 5871 (20110213) __________

The message was checked by ESET NOD32 Antivirus.

http://www.eset.com
