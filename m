Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jun 2011 23:15:29 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:42082 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491108Ab1FTVPV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Jun 2011 23:15:21 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 88A498BB4;
        Mon, 20 Jun 2011 23:15:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FKArP4lk4wFE; Mon, 20 Jun 2011 23:15:18 +0200 (CEST)
Received: from [192.168.0.152] (host-091-097-245-052.ewe-ip-backbone.de [91.97.245.52])
        by hauke-m.de (Postfix) with ESMTPSA id EBAB48BAD;
        Mon, 20 Jun 2011 23:15:17 +0200 (CEST)
Message-ID: <4DFFB865.6060105@hauke-m.de>
Date:   Mon, 20 Jun 2011 23:15:17 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110516 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To:     Julian Calaby <julian.calaby@gmail.com>
CC:     linux-wireless@vger.kernel.org, zajec5@gmail.com,
        linux-mips@linux-mips.org, mb@bu3sch.de, george@znau.edu.ua,
        arend@broadcom.com, b43-dev@lists.infradead.org,
        bernhardloos@googlemail.com, arnd@arndb.de, sshtylyov@mvista.com
Subject: Re: [RFC v2 05/12] bcma: add mips driver
References: <1308520209-668-1-git-send-email-hauke@hauke-m.de> <1308520209-668-6-git-send-email-hauke@hauke-m.de> <BANLkTinCrAMa3bmTsKpu4y7QGbSiU9jMXQ@mail.gmail.com>
In-Reply-To: <BANLkTinCrAMa3bmTsKpu4y7QGbSiU9jMXQ@mail.gmail.com>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 30468
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16619

On 06/20/2011 01:44 AM, Julian Calaby wrote:
> Hauke,
> 
> One minor comment
> 
> On Mon, Jun 20, 2011 at 07:50, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>> diff --git a/drivers/bcma/driver_mips.c b/drivers/bcma/driver_mips.c
>> new file mode 100644
>> index 0000000..d49f9af
>> --- /dev/null
>> +++ b/drivers/bcma/driver_mips.c
>> @@ -0,0 +1,232 @@
>> +/*
>> + * Sonics Silicon Backplane
> 
> Err, this is for BCMA, not SSB =)
> 
> Thanks,
> 
Hi Julian,

Oh bad, I copied this file from ssb and modified it, but missed the
header. This is fixed now, but I should have a closer look at the
comments in general.

Hauke
