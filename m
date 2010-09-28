Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Sep 2010 18:50:26 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16877 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491961Ab0I1QuX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Sep 2010 18:50:23 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ca21ced0000>; Tue, 28 Sep 2010 09:50:53 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 28 Sep 2010 09:50:19 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 28 Sep 2010 09:50:19 -0700
Message-ID: <4CA21CC6.9050101@caviumnetworks.com>
Date:   Tue, 28 Sep 2010 09:50:14 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100720 Fedora/3.0.6-1.fc12 Thunderbird/3.0.6
MIME-Version: 1.0
To:     "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
CC:     linux-mips@linux-mips.org
Subject: Re: License file header for a new file
References: <AEA634773855ED4CAD999FBB1A66D0760115A22F@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <AEA634773855ED4CAD999FBB1A66D0760115A22F@CORPEXCH1.na.ads.idt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Sep 2010 16:50:19.0448 (UTC) FILETIME=[3BF83380:01CB5F2D]
X-archive-position: 27877
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 22544

On 09/28/2010 07:40 AM, Ardelean, Andrei wrote:
> Hi,
>
> I am porting MIPS Linux from Malta to a new platform. I created a new
> file gd-memory.c from the original malta-memory.c and I modified the
> code to match the new platform. The original malta-memory.c has the
> following header:
> /*
>   * Carsten Langgaard, carstenl@mips.com
>   * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
>   *
>   *  This program is free software; you can distribute it and/or modify
> it
>   *  under the terms of the GNU General Public License (Version 2) as
>   *  published by the Free Software Foundation.
>   *
>   *  This program is distributed in the hope it will be useful, but
> WITHOUT
>   *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> or
>   *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> License
>   *  for more details.
>   *
>   *  You should have received a copy of the GNU General Public License
> along
>   *  with this program; if not, write to the Free Software Foundation,
> Inc.,
>   *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
>   *
>   * PROM library functions for acquiring/using memory descriptors given
> to
>   * us from the YAMON.
>   */
>
> What should be the correct header for gd-memory.c?
>

If there is code from the original file remaining, you should keep the 
original copyright message

If you made material changes to it, you could *add* your own copyright line.

David Daney
