Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Mar 2015 22:58:21 +0100 (CET)
Received: from mail-vc0-f182.google.com ([209.85.220.182]:39281 "EHLO
        mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007079AbbCDV6TzKsVa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Mar 2015 22:58:19 +0100
Received: by mail-vc0-f182.google.com with SMTP id hy4so4019648vcb.13
        for <linux-mips@linux-mips.org>; Wed, 04 Mar 2015 13:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=8yEyNrBreuDjd1qg3bmF0DlvmFGgfHF6mP54tcCpyG0=;
        b=kn6HSvas0HC7DScji/rmNIt8JtT4ultzD7Q8aWli1I5Rl88eweb7ArU6pWG4DfSD14
         fJiG+wKvrQfDLfP+IZuuXhQNNwMxt1h2bRCWksUe09Plmw/DaP48CxS+8ZIKCig5nE9m
         wJ9EHzTLtlaJ7Wr1fR490LKlEFRXDnREhd5qVH4i7kp3TbET1YF6db3YQ1k0A2xBLbRu
         zGn+lwnpAa4eRGW3Q5oEZ0eKsMkZRptoUfUtUh05hGc09XauDgNXfSoiRF3VWq9cm9i6
         x2SLw4AjaWMFyqKbgbjCmP8tNI3G9o+nOrNLOxoY4xa0/fNU1FYyVmDhrMaBG7oOWRAo
         XnEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=8yEyNrBreuDjd1qg3bmF0DlvmFGgfHF6mP54tcCpyG0=;
        b=e8z0Vy04jdt6Jga/QC/wL5fb7bhdp2gvtXxbf3au5T9U6Q4S/PdkJcBNmbWsY24zJJ
         lgaMUxt2s+qykL3B9NkXe5+BQ4iD6udGmC7vYjSWrEhlZY4phzoE6QYnxM3TxB1syo2p
         3lB4BL/wRlIGRrTqTYYbvprUqGwdf6kM5VFGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=8yEyNrBreuDjd1qg3bmF0DlvmFGgfHF6mP54tcCpyG0=;
        b=iL8c10CuG2BwiYZ0oTppimqxplVm2gYsZc8xIR60p4Z9+8EqjMMc96kxWjTaQGJWZ9
         GHX8JjslSzyMZ1be4q6KGSD8kXPqU0g/k+K1OSU9IagDxnd0ygRVReBbxgfcgfBZm1tr
         /Uss/pA2XtX5Cc3XG0vNInoyocY6mkxCeVbibv2DrYbIpoIbl2MBWfALD3ku6sdkqtYQ
         6A+75VUgTCQ8//vYUgXDiiXdANAk9OZkRAfP4C5H/R1uUdzjwE9DLCRmj35Sk6OeADWh
         +Jfxvr1cF8AHRkGQBcsVrQgmlpOC93Ete9rnp+3S+aX6zxz1h+K1ICNMWZx4teCb9Mmc
         pN7g==
X-Gm-Message-State: ALoCoQmanZ3kEiDFoa7h5PM4oo/BCT39ZBFVU7YedHwo4mGy/Pc8+mFk5rDew0XdOBgxk6kcNMYG
MIME-Version: 1.0
X-Received: by 10.52.12.169 with SMTP id z9mr9489965vdb.69.1425506294632; Wed,
 04 Mar 2015 13:58:14 -0800 (PST)
Received: by 10.52.172.35 with HTTP; Wed, 4 Mar 2015 13:58:14 -0800 (PST)
In-Reply-To: <20150304215437.GA22254@gmail.com>
References: <1425503454-7531-1-git-send-email-keescook@chromium.org>
        <20150304215437.GA22254@gmail.com>
Date:   Wed, 4 Mar 2015 13:58:14 -0800
X-Google-Sender-Auth: zy0HTN9D00MKiqG3pXp9VmhWx_c
Message-ID: <CAGXu5jJTGms38aWJgFerjaAxPLDkXuGAx69ihzUrcWZ0BMbpqg@mail.gmail.com>
Subject: Re: [PATCH v4 0/10] split ET_DYN ASLR from mmap ASLR
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Ismael Ripoll <iripoll@upv.es>,
        Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, "x86@kernel.org" <x86@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "David A. Long" <dave.long@linaro.org>,
        Andrey Ryabinin <a.ryabinin@samsung.com>,
        Arun Chandran <achandran@mvista.com>,
        Yann Droneaud <ydroneaud@opteya.com>,
        Min-Hua Chen <orca.chen@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Alex Smith <alex@alex-smith.me.uk>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Vineeth Vijayan <vvijayan@mvista.com>,
        Jeff Bailey <jeffbailey@google.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Borislav Petkov <bp@suse.de>,
        =?UTF-8?Q?Jan=2DSimon_M=C3=B6ller?= <dl9pf@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

On Wed, Mar 4, 2015 at 1:54 PM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Kees Cook <keescook@chromium.org> wrote:
>
>> To address the "offset2lib" ASLR weakness[1], this separates ET_DYN
>> ASLR from mmap ASLR, as already done on s390. The architectures
>> that are already randomizing mmap (arm, arm64, mips, powerpc, s390,
>> and x86), have their various forms of arch_mmap_rnd() made available
>> via the new CONFIG_ARCH_HAS_ELF_RANDOMIZE. For these architectures,
>> arch_randomize_brk() is collapsed as well.
>>
>> This is an alternative to the solutions in:
>> https://lkml.org/lkml/2015/2/23/442
>>
>> I've been able to test x86 and arm, and the buildbot (so far) seems
>> happy with building the rest.
>
> Ok, this looks really good - for all patches:
>
>    Reviewed-by: Ingo Molnar <mingo@kernel.org>

Great! Thanks for the suggestions and reviews. :)

-Kees

-- 
Kees Cook
Chrome OS Security
