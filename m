Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Mar 2010 17:44:35 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4642 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492239Ab0CVQob (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Mar 2010 17:44:31 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ba79e760001>; Mon, 22 Mar 2010 09:44:38 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 22 Mar 2010 09:44:26 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 22 Mar 2010 09:44:26 -0700
Message-ID: <4BA79E69.1040803@caviumnetworks.com>
Date:   Mon, 22 Mar 2010 09:44:25 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8) Gecko/20100301 Fedora/3.0.3-1.fc12 Thunderbird/3.0.3
MIME-Version: 1.0
To:     Zhuang Yuyao <mlistz@gmail.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [BUG?] cavium cn56xx and dma_map_single warning
References: <e732b6801003220001m7e08bbf7w20ba62d42f30a190@mail.gmail.com>
In-Reply-To: <e732b6801003220001m7e08bbf7w20ba62d42f30a190@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Mar 2010 16:44:26.0259 (UTC) FILETIME=[EEF75630:01CAC9DE]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26290
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 03/22/2010 12:01 AM, Zhuang Yuyao wrote:
> Hi,
>
> I've got a strange dma error on my cavium cn56xx board.
>
> ......
> dma_map_single: Warning: Mapping memory address that might conflict
> with devices 0xfbb8f000-0xfbb8ffff
> dma_map_single: Warning: Mapping memory address that might conflict
> with devices 0xfb2ef000-0xfb2f0fff
> dma_map_single: Warning: Mapping memory address that might conflict
> with devices 0xfb3de000-0xfb3defff
> dma_map_single: Warning: Mapping memory address that might conflict
> with devices 0xfb3dd000-0xfb3ddfff
> dma_map_single: Warning: Mapping memory address that might conflict
> with devices 0xfac28000-0xfac29fff
> dma_map_single: Warning: Mapping memory address that might conflict
> with devices 0xfad1a000-0xfad1bfff
> .....
>
> this error appeared when I plugged 4G or 8G ram on the board, if there
> is only 2G ram on the board, the error never happened.
>
> an adaptec 3405 pci-e raid card is plugged on the board, and a
> harddisk attached. the program i am running is a postgresql server
> with more than 20 million record, so do a count(*) will let postgresql
> consume almost all of the available memory. while there is 4G ram, the
> 'free' command reported that the free memory is below 18M.
>
> then the error kept printing on the console for a while, then kernel panic.
>
> the warning message is come from arch/mips/cavium-octeon/dma-octeon.c
>
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/mips/cavium-octeon/dma-octeon.c;h=be531ec1f2064b590b58dfe8b4db4f5534999bab;hb=HEAD
>
> i tried several raid card from different producer, including LSI and
> Adaptec. the same error always happened while there are more than or
> equal to 4G memory on the board.
>
> Would you please give some advice on this issue? any help will be appreciated.

This is a known issue.

passing mem==3072M will restrict kernel memory usage thus avoiding the 
issue.

David Daney



>
> Thanks.
>
> Zhuang Yuyao
>
