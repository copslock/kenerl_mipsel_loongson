Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Mar 2015 05:34:11 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:59745 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008338AbbC2DeBGPgp8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Mar 2015 05:34:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=YLWa40En8DvvZ68sUfJ/riNyWzhuJch4Rq1RdvPpV9U=;
        b=KNIcrl9PQPkFRqekcUNiwz8hOZms6zjRmF6GhGOnArKXTPv+bcMyEDCF4uIPhUhJ7PM1kEyMCS+L8n3bnG+7SDmp/fImky4MjpKYqnCdwiLmzsGcnPcyj/T44W50535X3oVrEYGQWLjrUNrBQtrYFo40zRru+j7/HlXFHttCnZo=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1Yc3z1-000Ekq-9l
        for linux-mips@linux-mips.org; Sun, 29 Mar 2015 03:33:55 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:47105 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1Yc3z0-000Ek6-P8; Sun, 29 Mar 2015 03:33:55 +0000
Message-ID: <551772A2.90704@roeck-us.net>
Date:   Sat, 28 Mar 2015 20:33:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Wim Van Sebroeck <wim@iguana.be>,
        David Daney <david.daney@cavium.com>,
        linux-watchdog@vger.kernel.org
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] watchdog: octeon: fix some trivial coding style issues
References: <1427565940-22951-1-git-send-email-aaro.koskinen@iki.fi> <1427565940-22951-2-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1427565940-22951-2-git-send-email-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020202.551772A3.00C8,ss=1,re=0.001,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.001
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: C_4847,
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 5
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 0
X-CTCH-SenderID-TotalConfirmed: 0
X-CTCH-SenderID-TotalBulk: 0
X-CTCH-SenderID-TotalVirus: 0
X-CTCH-SenderID-TotalRecipients: 0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: mailgid no entry from get_relayhosts_entry
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46587
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 03/28/2015 11:05 AM, Aaro Koskinen wrote:
> Fix some trivial coding style issues to reduce noise from static analyzers.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>


Reviewed-by: Guenter Roeck <linux@roeck-us.net>
