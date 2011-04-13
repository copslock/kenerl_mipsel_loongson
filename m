Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Apr 2011 19:38:10 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:1476 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491772Ab1DMRiG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Apr 2011 19:38:06 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4da5dfb60000>; Wed, 13 Apr 2011 10:39:02 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 13 Apr 2011 10:38:03 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 13 Apr 2011 10:38:02 -0700
Message-ID: <4DA5DF7A.1030207@caviumnetworks.com>
Date:   Wed, 13 Apr 2011 10:38:02 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     philby john <pjohn@mvista.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Octeon: add option to ignore PT_NOTE section
References: <1302710833.14458.1.camel@localhost.localdomain>
In-Reply-To: <1302710833.14458.1.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Apr 2011 17:38:02.0981 (UTC) FILETIME=[8A256950:01CBFA01]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29751
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 04/13/2011 09:07 AM, philby john wrote:
> From: Philby John<pjohn@mvista.com>

^^^^^^^^ I believe that statement to be not entirely correct.

Perhaps you should change it to something like:
From: David Daney <ddaney@caviumnetworks.com>


> Date: Wed, 13 Apr 2011 20:46:32 +0530
> Subject: [PATCH] MIPS: Octeon: add option to ignore PT_NOTE section
>
> Some early Octeon bootloaders cannot process PT_NOTE program
> headers as reported in numerous sections of the web, here is
> an example http://www.spinics.net/lists/mips/msg37799.html
> Loading usually fails with such an error ...
> Error allocating memory for elf image!
>
> The work around usually is to strip the .notes section by using
> such a command $mips-gnu-strip -R .notes vmlinux -o fixed-vmlinux
> It is expected that the vmlinux image got after compilation be
> bootable. Add a Kconfig option to ignore the PT_NOTE section.
>
> Signed-off-by: Philby John<pjohn@mvista.com>
> ---
