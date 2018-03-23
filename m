Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2018 18:43:40 +0100 (CET)
Received: from mail-lf0-x241.google.com ([IPv6:2a00:1450:4010:c07::241]:33708
        "EHLO mail-lf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990498AbeCWRneJXBhq convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Mar 2018 18:43:34 +0100
Received: by mail-lf0-x241.google.com with SMTP id x205-v6so19484862lfa.0;
        Fri, 23 Mar 2018 10:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QZq4UFrT02MMmDvS3rVa2L5oKghNblZL+cJZh/o9UH0=;
        b=JHbHee0h53JbfZKtjVUj//P0oos2gKonfd3jDsU2XL+ui/bnVXZBBH65zIZIJFUOg7
         1/7VcqNXhE7QIDeve1TwFda4oIzW/JKlzDV+NbAJKKynq3G7/GpppSCf9/zYm2VuyRP1
         eIqsCfppiFkzU6fksNtPdReW4Jke8mmxJ2dKWNPp9uXJpsVG9DObYc85XPw1C5yNkIpA
         q4fGTyV41TIA3ehtj4bzmgeYlgDpFE+k2NTZVgo0sozT3gOTWWosGkeW0evpf+7GdaWI
         eoCN71eNSbtsZkCiqKcK2nuq4G+e3qkZlHwvSp9iTjayojLi4q0Tj1B2zTChmWDSmwjO
         RsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QZq4UFrT02MMmDvS3rVa2L5oKghNblZL+cJZh/o9UH0=;
        b=ufLnT27cIdf3VgmvS1u3K7zYUgMqC7I7+5w7RDyni4zoVgz/rpQHKt7YYH2oYSuL9o
         AsKeo75mhxA7Ieg4vMIJvSB6V81GvUWZgBGhg0PMV8jChFlsupeblJ4Jeimi4r/VZs0e
         7EnYtvtT5ajNhlinYACvDvRRXw0G4q6qumR8FXACMWi3TYyO3cw77m/I9TDCNQaUrt6J
         Au7Qm35Gl3K+ZwvQMkUIBOdJ+x3+/GPkWgXsM+soZEIReuMWVO9wfG0IhFyH+LA6i4K7
         JDyW6wetL0Ym8gwW2bXm7kw4ZmwvII/2D8uyEVujluqL34qRINwF0WrZf39B7BQJzpBt
         z/vA==
X-Gm-Message-State: AElRT7E0TvkryIrf0vvPJMUATHS503U1phVCTmyNQCbpMpXJ1koW90m7
        yzpF0VTsjtnvCpdDpBOUueM=
X-Google-Smtp-Source: AG47ELsm3SSvZMKhrtdKOCSDDRM/445Cf1QIFUfL/ApGlTQAxukWZUdRrtOYDTWVnwvMSsy++jwWiQ==
X-Received: by 2002:a19:4c56:: with SMTP id z83-v6mr19797192lfa.141.1521827008444;
        Fri, 23 Mar 2018 10:43:28 -0700 (PDT)
Received: from [192.168.1.3] (broadband-188-255-70-164.moscow.rt.ru. [188.255.70.164])
        by smtp.gmail.com with ESMTPSA id l1sm1967810ljc.91.2018.03.23.10.43.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:43:27 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [RFC PATCH v2 1/2] Randomization of address chosen by mmap.
From:   Ilya Smith <blackzert@gmail.com>
In-Reply-To: <20180322135314.61efce938293e051e118fa46@linux-foundation.org>
Date:   Fri, 23 Mar 2018 20:43:25 +0300
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        vgupta@synopsys.com, linux@armlinux.org.uk, tony.luck@intel.com,
        fenghua.yu@intel.com, ralf@linux-mips.org, jejb@parisc-linux.org,
        Helge Deller <deller@gmx.de>, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        nyc@holomorphy.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
        gregkh@linuxfoundation.org, deepa.kernel@gmail.com,
        Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>, kstewart@linuxfoundation.org,
        pombredanne@nexb.com, steve.capper@arm.com, punit.agrawal@arm.com,
        aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
        Kees Cook <keescook@chromium.org>, bhsharma@redhat.com,
        riel@redhat.com, nitin.m.gupta@oracle.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, ross.zwisler@linux.intel.com,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <547032AD-605D-46AF-9DA6-C2ECA01923E1@gmail.com>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <1521736598-12812-2-git-send-email-blackzert@gmail.com>
 <20180322135314.61efce938293e051e118fa46@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3445.5.20)
Return-Path: <blackzert@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blackzert@gmail.com
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


> On 22 Mar 2018, at 23:53, Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> On Thu, 22 Mar 2018 19:36:37 +0300 Ilya Smith <blackzert@gmail.com> wrote:
> 
>> include/linux/mm.h |  16 ++++--
>> mm/mmap.c          | 164 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> 
> You'll be wanting to update the documentation. 
> Documentation/sysctl/kernel.txt and
> Documentation/admin-guide/kernel-parameters.txt.
> 

Sure, thanks for pointing there. I will add few lines there after discussion them
here.

>> ...
>> 
>> @@ -2268,6 +2276,9 @@ extern unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info);
>> static inline unsigned long
>> vm_unmapped_area(struct vm_unmapped_area_info *info)
>> {
>> +	/* How about 32 bit process?? */
>> +	if ((current->flags & PF_RANDOMIZE) && randomize_va_space > 3)
>> +		return unmapped_area_random(info);
> 
> The handling of randomize_va_space is peculiar.  Rather than being a
> bitfield which independently selects different modes, it is treated as
> a scalar: the larger the value, the more stuff we randomize.
> 
> I can see the sense in that (and I wonder what randomize_va_space=5
> will do).  But it is...  odd.
> 
> Why did you select randomize_va_space=4 for this?  Is there a mode 3
> already and we forgot to document it?  Or did you leave a gap for
> something?  If the former, please feel free to fix the documentation
> (in a separate, preceding patch) while you're in there ;)
> 

Yes, I was not sure about correct value so leaved some gap for future. Also
according to current implementation this value used like a scalar. But I’m
agree bitfield looks more flexible for the future. I think right now I can leave
3 as value for my patch and it could be fixed any time in the future. What
do you think about it?

>> 	if (info->flags & VM_UNMAPPED_AREA_TOPDOWN)
>> 		return unmapped_area_topdown(info);
>> 	else
>> @@ -2529,11 +2540,6 @@ int drop_caches_sysctl_handler(struct ctl_table *, int,
>> void drop_slab(void);
>> void drop_slab_node(int nid);
>> 
>> 
>> ...
>> 
>> @@ -1780,6 +1781,169 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>> 	return error;
>> }
>> 
>> +unsigned long unmapped_area_random(struct vm_unmapped_area_info *info)
>> +{
> 
> This function is just dead code if CONFIG_MMU=n, yes?  Let's add the
> ifdefs to make it go away in that case.
> 

Thanks, I missed that case. I will fix it.

>> +	struct mm_struct *mm = current->mm;
>> +	struct vm_area_struct *vma = NULL;
>> +	struct vm_area_struct *visited_vma = NULL;
>> +	unsigned long entropy[2];
>> +	unsigned long length, low_limit, high_limit, gap_start, gap_end;
>> +	unsigned long addr = 0;
>> +
>> +	/* get entropy with prng */
>> +	prandom_bytes(&entropy, sizeof(entropy));
>> +	/* small hack to prevent EPERM result */
>> +	info->low_limit = max(info->low_limit, mmap_min_addr);
>> +
>> 
>> ...
>> 
>> +found:
>> +	/* We found a suitable gap. Clip it with the original high_limit. */
>> +	if (gap_end > info->high_limit)
>> +		gap_end = info->high_limit;
>> +	gap_end -= info->length;
>> +	gap_end -= (gap_end - info->align_offset) & info->align_mask;
>> +	/* only one suitable page */
>> +	if (gap_end ==  gap_start)
>> +		return gap_start;
>> +	addr = entropy[1] % (min((gap_end - gap_start) >> PAGE_SHIFT,
>> +							 0x10000UL));
> 
> What does the magic 10000 mean?  Isn't a comment needed explaining this?
> 
>> +	addr = gap_end - (addr << PAGE_SHIFT);
>> +	addr += (info->align_offset - addr) & info->align_mask;
>> +	return addr;
>> +}
>> 
>> ...
>> 
> 

This one what I fix by next patch. I was trying to make patches separate to make
it easier to understand them. This constant came from last version discussion 
and honestly doesn’t means much. I replaced it with Architecture depended limit
that as I plan would be CONFIG value as well.

This value means maximum number of pages we can move away from the next
vma. The less value means less security but less memory fragmentation. Any way
on 64bit systems memory fragmentation is not such a big problem.
