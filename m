Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jun 2013 23:27:41 +0200 (CEST)
Received: from mail-pa0-f52.google.com ([209.85.220.52]:43148 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835128Ab3FEV1jYeTfB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Jun 2013 23:27:39 +0200
Received: by mail-pa0-f52.google.com with SMTP id bg2so1259262pad.11
        for <linux-mips@linux-mips.org>; Wed, 05 Jun 2013 14:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=qpiHl8RIAxSZHUSV7E8pJXrouWZuXzGrqfH7Qvm7/B4=;
        b=dbCqKCoeMk3/Z/ECe8kfngT4FKh8ROhdqzMK0gJRED6GEezl9YLVKdi6jYXKwKOkPl
         /4BnVmehB4P7ngp5Fk7WJwrCUtC0Pjo62Bu1fSwv1SVFrH1PAxnQ3Zmj8mvIw1tJnm2x
         1zCYq+N/OIS/pWikAjWz82VR5XgYo7IEQDjB93IkDZS3AsmuLZx9TpzbbPiu2fmSnfZK
         wmWvFooRFMN7gEJq7lFkrEnGZ1Dvylz+/Apq2kP9uCUGNm4wELT8jdPLknVHdQ0vjrZZ
         BsI3YH8lHY821adtvt+4EHTtI7RIcf6qJNDx+bPoLqvn/Zj9Gof5YgwR8aE5XOpiBItD
         s5+A==
X-Received: by 10.66.144.98 with SMTP id sl2mr36238407pab.92.1370467652751;
        Wed, 05 Jun 2013 14:27:32 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id nt2sm69607534pbc.17.2013.06.05.14.27.31
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 05 Jun 2013 14:27:31 -0700 (PDT)
Message-ID: <51AFAD42.10603@gmail.com>
Date:   Wed, 05 Jun 2013 14:27:30 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Jonas Gorski <jogo@openwrt.org>
CC:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v6] MIPS: micromips: Fix improper definition of ISA exception
 bit.
References: <1370461798-20296-1-git-send-email-Steven.Hill@imgtec.com> <51AFA540.5010207@gmail.com> <51AFAA8C.6080002@imgtec.com> <CAOiHx=mFqC=GN0jmb9PXpt+JapfWoP3Pu5NM0sp=F_uAZuwUEA@mail.gmail.com>
In-Reply-To: <CAOiHx=mFqC=GN0jmb9PXpt+JapfWoP3Pu5NM0sp=F_uAZuwUEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36712
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

On 06/05/2013 02:23 PM, Jonas Gorski wrote:
> On Wed, Jun 5, 2013 at 11:15 PM, Steven J. Hill <Steven.Hill@imgtec.com> wrote:
>> On 06/05/2013 03:53 PM, David Daney wrote:
>>>
>>>
>>> You can only manipulate this bit if you know microMIPS is supported.  So
>>> I think you should either not touch it for the non-microMIPS case, or
>>> make the write conditional on the presence of microMIPS support in the
>>> CPU.
>>>
>> I decided to surround with SYS_SUPPORTS_MICROMIPS so the function could be
>> optimized out in v7 of the patch.
>
> Since this is (AFAICT) run after cpu_probe, and cpu probe sets
> MIPS_CPU_MICROMIPS in options[0] if config3 has  MIPS_CONF3_ISA set
> (as seen in the context), couldn't you do just the following in
> cpu_trap:
>
> 	if (cpu_has_mmips) {
> 		unsigned int config3 = read_c0_config3();
>
> 		if (IS_ENABLED(CONFIG_CPU_MICROMIPS))
> 			write_c0_config3(config3 | MIPS_CONF3_ISA_OE);
> 		else
> 			write_c0_config3(config3 & ~MIPS_CONF3_ISA_OE);
> 	}
>

Yes, that would work.  It even looks nicer.

David Daney



>
> Regards
> Jonas
>
>
