Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2011 22:38:54 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:59995 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903829Ab1KVViq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Nov 2011 22:38:46 +0100
Received: by ggki1 with SMTP id i1so831412ggk.36
        for <multiple recipients>; Tue, 22 Nov 2011 13:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=OTe1NWb5ZLVGTGRj6kNzFlDGFs/jCu0XfzAVsuE7CTY=;
        b=kFUTdGFvRFJQzLQJ175Q85kgnJ31WYjyduNbWSKInCmff8kuKS7drlylzHWpGzHtab
         kaIZGwd4UYEJK9Y9dgEFKGPfJcEyBURoOF3XO6YBwK1xZq+fXFVWj/Rkyiiw7h4G9V5y
         M8LeB6tNFUzBLiqelhnQuRvxKy1uL32eIXgNY=
Received: by 10.236.46.193 with SMTP id r41mr13575056yhb.44.1321997920619;
        Tue, 22 Nov 2011 13:38:40 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id h20sm21366288yhj.18.2011.11.22.13.38.39
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Nov 2011 13:38:40 -0800 (PST)
Message-ID: <4ECC165D.60300@gmail.com>
Date:   Tue, 22 Nov 2011 13:38:37 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Michal Marek <mmarek@suse.cz>
CC:     David Daney <ddaney.cavm@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-embedded@vger.kernel.org" <linux-embedded@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH RFC 3/5] kbuild/extable: Hook up sortextable into the
 build system.
References: <1321645068-20475-1-git-send-email-ddaney.cavm@gmail.com> <1321645068-20475-4-git-send-email-ddaney.cavm@gmail.com> <4EC9046C.3050708@suse.cz>
In-Reply-To: <4EC9046C.3050708@suse.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 31931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19109

On 11/20/2011 05:45 AM, Michal Marek wrote:
> On 18.11.2011 20:37, David Daney wrote:
>> +	$(if $(CONFIG_BUILDTIME_EXTABLE_SORT),				\
>> +	$(Q)$(if $($(quiet)cmd_sortextable),				\
>> +	  echo '  $($(quiet)cmd_sortextable)  vmlinux'&&)		\
>> +	  $(cmd_sortextable)  vmlinux)
>
> Why do you opencode $(call cmd,sortextable) here?
>

Mostly just mimicking the other code in the vicinity.

I will try to improve it in the next version of the patch.

Thanks,
David Daney
