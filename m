Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Oct 2015 22:45:09 +0100 (CET)
Received: from mail-io0-f179.google.com ([209.85.223.179]:35720 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011412AbbJ0VpHy9-vW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Oct 2015 22:45:07 +0100
Received: by iofz202 with SMTP id z202so236294118iof.2;
        Tue, 27 Oct 2015 14:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=7L9gwF9sAs8OpCtYBeLMc73176BuptLcqI/O795++BM=;
        b=LYCKLALWJFkKEI/g5w66S3KB0yu58ev2TehVFjrP2QTy1SlP2DM7oNlVzO5WyReYRc
         ++8MrbhRW66HOM1ppvC+x9m5nCJAIZQ5VV4EQHMCMDXjJXGrVmG7lXHDcYg8NAd548IS
         2VwrtVX/Q2kghQcfTn8k/Wo1XjOlg0P62cIADbckp5C+FiE4n4nyNXgHgnWKLh2235f1
         Pkcm28bQEpdrLND6mfHmDFy6EEORwLpN6lUaqo+UkLVqD5VizIQYb4pSmaZljFltRaZp
         mm26F22+Ldir5VbT5WWMmL5Df2jIBgEwX3frddyL5uNlYMMRWw05eKQYzcU4KXFIPReH
         bYNA==
X-Received: by 10.107.62.5 with SMTP id l5mr5393042ioa.45.1445982301891;
        Tue, 27 Oct 2015 14:45:01 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by smtp.googlemail.com with ESMTPSA id rt7sm8886223igb.11.2015.10.27.14.44.59
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 27 Oct 2015 14:44:59 -0700 (PDT)
Message-ID: <562FF05A.508@gmail.com>
Date:   Tue, 27 Oct 2015 14:44:58 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Alex Smith <alex.smith@imgtec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [v3, 3/3] MIPS: VDSO: Add implementations of gettimeofday() and
 clock_gettime()
References: <1445417864-31453-1-git-send-email-markos.chandras@imgtec.com> <5629904A.2070400@imgtec.com> <20151027144748.GA23785@linux-mips.org> <562FE29C.8040106@imgtec.com> <562FE678.2030307@gmail.com> <562FE96C.3070002@imgtec.com>
In-Reply-To: <562FE96C.3070002@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49726
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 10/27/2015 02:15 PM, Leonid Yegoshin wrote:
> On 10/27/2015 02:02 PM, David Daney wrote:
>> On 10/27/2015 01:46 PM, Leonid Yegoshin wrote:
>> [...]
>>>
>>> And finally. clock scaling - what we would do if there are two CPUs with
>>> different clock ratios in system? It seems like common kernel timing
>>> subsystem can handle that.
>>>
>>
>> The code that executes in userspace must have access to a consistent
>> clock source.  If you are running on a SMP system that doesn't have
>> synchronized CP0.Count registers, then your gettimeofday() cannot use
>> CP0.Count (RDHWR $2).
>
> Right, I agree.
>
>>
>> As far as I know, CP0.Count is the only available counter visible to
>> userspace, so you would have to disable the accelerated versions of
>> gettimeofday() where you cannot assert that the counters are always
>> synchronized.
>
> Any system with GIC may have access to the same GIC global counter in a
> special separate page available for mapping by user in RO mode and it
> seems Alex did that.
>
> Besides that this GIC global counter is used as a major system
> clocksource in systems with GIC.

Yes, I had forgotten about the GIC thing.

In any event, there is a set of systems where we could run into problems 
with unsynchronized clocks.  There needs to be an easy way to 
enable/disable the gettimeofday() acceleration at run time based on the 
properties of the counter (GIC, CP0.Count, or whatever) chosen at boot time.

For example, On OCTEON single-chip systems we synchronize the the 
counters and they don't drift.  So, we can use CPO.Count.  However, on 
two-chip NUMA configurations there may be clock drift between the two 
chips, so CPO.Count cannot be used as a clocksource.  We have a single 
kernel image that runs on both types of systems, so we have to be able 
to enable/disable the gettimeofday() acceleration.

David Daney


>
> - Leonid
>
>
>
>
