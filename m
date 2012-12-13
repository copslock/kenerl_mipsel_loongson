Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Dec 2012 00:39:08 +0100 (CET)
Received: from mail-da0-f49.google.com ([209.85.210.49]:33125 "EHLO
        mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6829678Ab2LMXjHdsbdz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Dec 2012 00:39:07 +0100
Received: by mail-da0-f49.google.com with SMTP id v40so1018150dad.36
        for <multiple recipients>; Thu, 13 Dec 2012 15:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=VTABqe3S7OO3Ep3/PurOxZNtPmjmh2USs6RfbyoMKeU=;
        b=gd0l1yStgBASdBpIkGL+f/nUUzFVW5TsV3mrR/pqTGHH54GTtoxJbsGipYKVujXDg3
         XLBY0ulfrhUquhUFSgpPyuckTef3hNfssMj1VX3NVOw1bLKzicE9ufv2lsPDHowEHIEh
         qWSCVW4LrBebkY3bpJ7/pvRFnqQylcYAJXW4HG/Z1atCQSilIvYTx8MFxKw0CRe6RKNF
         T+Tbk2JkPM0Y7LderZxNT+h5HYDk+lbXdeATWFskpBSRvi40uzRhXTsi01eHBYdKxrO/
         puagHbyJ5snv1YFkjk8kKYed0z1TM86Va5RUDMH7cvfCxQu218wfi7ho+KciKpK+h6mf
         v1IQ==
Received: by 10.66.90.72 with SMTP id bu8mr10548439pab.69.1355441940381;
        Thu, 13 Dec 2012 15:39:00 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id k4sm2022252paz.26.2012.12.13.15.38.59
        (version=SSLv3 cipher=OTHER);
        Thu, 13 Dec 2012 15:38:59 -0800 (PST)
Message-ID: <50CA6712.1060809@gmail.com>
Date:   Thu, 13 Dec 2012 15:38:58 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     "Steven J. Hill" <sjhill@mips.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v4] MIPS: Make CP0 config registers readable via sysfs.
References: <1355436915-24381-1-git-send-email-sjhill@mips.com> <alpine.LFD.2.02.1212132325180.5950@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.02.1212132325180.5950@eddie.linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35285
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 12/13/2012 03:27 PM, Maciej W. Rozycki wrote:
> On Thu, 13 Dec 2012, Steven J. Hill wrote:
>
>> Allow reading of CP0 config registers via sysfs for each core
>> in the system. The registers will show up in sysfs at the path:
>>
>>     /sys/devices/system/cpu/cpuX/configX
>
>   You're exporting privileged context outside the kernel -- have all the
> security implications been considered?

Can you give an example of what would be risky?


>  At the very least I don't think
> these files should be word-readable.
>


According to Steven's earlier comments, all he really cares about are 
the ASEs implemented.

We have a patch (that I will send soon) that exports the Cache 
configurations via the same method that x86 Cache information is 
reported, so that part of the config register information would be 
reported separately.

The rest of the CP0_ConfigX bits really report things that are only 
useful to privileged mode software, so perhaps they shouldn't be reported.

David Daney
