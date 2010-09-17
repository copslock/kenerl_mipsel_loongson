Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Sep 2010 21:03:13 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:14974 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491087Ab0IQTDK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Sep 2010 21:03:10 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c93bb8a0000>; Fri, 17 Sep 2010 12:03:38 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 17 Sep 2010 12:03:07 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 17 Sep 2010 12:03:07 -0700
Message-ID: <4C93BB61.7000004@caviumnetworks.com>
Date:   Fri, 17 Sep 2010 12:02:57 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100720 Fedora/3.0.6-1.fc12 Thunderbird/3.0.6
MIME-Version: 1.0
To:     Maciej Drobniuch <maciej@drobniuch.pl>
CC:     linux-mips@linux-mips.org
Subject: Re: mips64-octeon-linux-gnu
References: <AANLkTinU_bBu8n9-dW31ATqA-CKX+UHyNOkRHHhZAiro@mail.gmail.com>
In-Reply-To: <AANLkTinU_bBu8n9-dW31ATqA-CKX+UHyNOkRHHhZAiro@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Sep 2010 19:03:07.0031 (UTC) FILETIME=[F679A270:01CB569A]
X-archive-position: 27763
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 13906

On 09/17/2010 11:53 AM, Maciej Drobniuch wrote:
> Hi ALL!
> I'm new to linux-mips world!
> I'm looking for a toolchain called mips64-octeon-linux-gnu
> Does anyone know where i could get one ?
> BIG THANKS!

There are several options:

1) It is supplied as part of the Octeon SDK which may be obtained from 
the vendor.

2) You can build it yourself (How to do this is left as an exercise for 
the reader).

3) Use mips64-unknown-linux-gnu instead.

David Daney
