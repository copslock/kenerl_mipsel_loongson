Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2011 06:05:31 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:1661 "EHLO MMS3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490946Ab1EQEFZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 May 2011 06:05:25 +0200
Received: from [10.9.200.133] by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Mon, 16 May 2011 21:08:34 -0700
X-Server-Uuid: B55A25B1-5D7D-41F8-BC53-C57E7AD3C201
Received: from IRVEXCHCCR01.corp.ad.broadcom.com ([10.252.49.30]) by
 IRVEXCHHUB02.corp.ad.broadcom.com ([10.9.200.133]) with mapi; Mon, 16
 May 2011 21:04:52 -0700
From:   "Jian Peng" <jipeng@broadcom.com>
To:     "Kevin Cernekee" <cernekee@gmail.com>
cc:     "David Daney" <ddaney@caviumnetworks.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "Ralf Baechle" <ralf@linux-mips.org>
Date:   Mon, 16 May 2011 21:04:53 -0700
Subject: Re: patch to support topdown mmap allocation in MIPS
Thread-Topic: patch to support topdown mmap allocation in MIPS
Thread-Index: AcwUR5bBt8/u3D2oTGCKecpzeVAkkw==
Message-ID: <0C7496DB-A6E6-41B1-AAEF-85C890717959@broadcom.com>
References: <E18F441196CA634DB8E1F1C56A50A8743242B54C8A@IRVEXCHCCR01.corp.ad.broadcom.com>
 <4DD1BD72.2000408@caviumnetworks.com>
 <BANLkTikq04wuK=bz+Lieavmm3oDtoYWKxg@mail.gmail.com>
In-Reply-To: <BANLkTikq04wuK=bz+Lieavmm3oDtoYWKxg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
MIME-Version: 1.0
X-WSS-ID: 61CF2B484NS8529404-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <jipeng@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30059
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jipeng@broadcom.com
Precedence: bulk
X-list: linux-mips

Good points. I cannot access working system now and will investigate it further tomorrow.

On May 16, 2011, at 6:27 PM, "Kevin Cernekee" <cernekee@gmail.com> wrote:

> On Mon, May 16, 2011 at 5:12 PM, David Daney <ddaney@caviumnetworks.com> wrote:
>> On 05/16/2011 02:09 PM, Jian Peng wrote:
>>>  #define COLOUR_ALIGN(addr,pgoff)                              \
>>>        ((((addr) + shm_align_mask)&  ~shm_align_mask) +        \
>>>         (((pgoff)<<  PAGE_SHIFT)&  shm_align_mask))
> 
> I see COLOUR_ALIGN in arch/{arm,mips,sh,sparc} .  All sorts of
> embedded platforms have to worry about cache aliases nowadays.
> 
> Do you think this logic could be folded into the generic
> implementations in mm/mmap.c ?  Or is there something else inside our
> arch_get_unmapped_area* functions that's really, irreparably unique to
> MIPS?
> 
>>> +#ifdef CONFIG_32BIT
>>> +       task_size = TASK_SIZE;
>>> +#else /* Must be CONFIG_64BIT*/
>>> +       task_size = test_thread_flag(TIF_32BIT_ADDR) ? TASK_SIZE32 :
>>> TASK_SIZE;
>>> +#endif
> 
> Can the "#else" clause and "task_size" local variable be eliminated?
> TASK_SIZE now performs this check automatically (although that wasn't
> always the case).
> 
