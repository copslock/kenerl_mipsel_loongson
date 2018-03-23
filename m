Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2018 18:49:25 +0100 (CET)
Received: from mail-lf0-x242.google.com ([IPv6:2a00:1450:4010:c07::242]:37478
        "EHLO mail-lf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991307AbeCWRtLth8cq convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Mar 2018 18:49:11 +0100
Received: by mail-lf0-x242.google.com with SMTP id m16-v6so15756079lfc.4;
        Fri, 23 Mar 2018 10:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jQmHZjnJbgzm5Bnta7AxMgcjy2Bp3CXXFf+gGk9Ctfs=;
        b=egpWFPxze82JEZupHy+pKSf4RySiS/MJfiI9BpD7/a4UXFf3rBRbHAw+XIIV/eC7/r
         vDgjsIiExoYRVFTaG9rxZVDRHJy4m+HHv1YUPKDMMPNzGcGD/6GUnVmtGeC2pJKf23fL
         QjmFlM/JxeG5syAZ13fuUvLk09LayA0H26sDrPTeA130DHDDQdZcxVrJaPyfEANI3pWI
         QTL82sWu/AOIcPn8WFp8TceGbrv6UwPMXk+L9C3oPdxuZNNn7DfIOha8uEyQ2xk1nco0
         yg+126LKwm9LqJE+/bRdd90nSy4pEmUIJdzY2C0b7O95wckq7jOxEsD47RhtmWdX7OJD
         UHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jQmHZjnJbgzm5Bnta7AxMgcjy2Bp3CXXFf+gGk9Ctfs=;
        b=LCFjwGol+73/APlmUjShty/bXYOzK20hlzqIdSYmTCNonVDlsrFU3mloyNiSeRkAJW
         xYJzuo3KaW/X9aSDfUv95Dvf1084p8fnDJIriySzFYQH/GsymPDHlX9y1m8H+ruZLQjG
         v0778JOwQ2fHc5b8tNvRcHNmVEx1ZDORETZljCavpKKD7EJPHOpJ7k6N8uGUKnF/QM/f
         SkgWMF2honVIVBxGGhFHaU8Up1HIiH+CFaEDEwj3itfXGkXv7c60HYrbzbdf/KLgT+vm
         7vSmIz5TAO0ss27Y8/caAhbiDsTN/xFSMg/ZSFPFMcVa3dch3xw6XUFdolQz4EcSdJal
         M3qw==
X-Gm-Message-State: AElRT7HCWIoVwI7Ed3C58T7hCdujQn9oUya04URsjOfSalFqb7g1/5S3
        1+kvtYeZyc9L2+El1gwkhnc=
X-Google-Smtp-Source: AG47ELuRtAiE5GxJ4PVlasYQbBVUoZzWlqey9KsMKVVJwaWDGj31q8vofooz0Xfhmk8aYru+zAB7Aw==
X-Received: by 2002:a19:1c0f:: with SMTP id c15-v6mr10866259lfc.44.1521827346362;
        Fri, 23 Mar 2018 10:49:06 -0700 (PDT)
Received: from [192.168.1.3] (broadband-188-255-70-164.moscow.rt.ru. [188.255.70.164])
        by smtp.gmail.com with ESMTPSA id t17-v6sm2332015lfi.30.2018.03.23.10.49.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:49:05 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [RFC PATCH v2 2/2] Architecture defined limit on memory region
 random shift.
From:   Ilya Smith <blackzert@gmail.com>
In-Reply-To: <20180322135448.046ada120ecd1ab3dd8f94aa@linux-foundation.org>
Date:   Fri, 23 Mar 2018 20:49:03 +0300
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        vgupta@synopsys.com, linux@armlinux.org.uk, tony.luck@intel.com,
        fenghua.yu@intel.com, jhogan@kernel.org, ralf@linux-mips.org,
        jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        nyc@holomorphy.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
        gregkh@linuxfoundation.org, deepa.kernel@gmail.com,
        mhocko@suse.com, hughd@google.com, kstewart@linuxfoundation.org,
        pombredanne@nexb.com, steve.capper@arm.com, punit.agrawal@arm.com,
        paul.burton@mips.com, aneesh.kumar@linux.vnet.ibm.com,
        npiggin@gmail.com, keescook@chromium.org, bhsharma@redhat.com,
        riel@redhat.com, nitin.m.gupta@oracle.com,
        kirill.shutemov@linux.intel.com, dan.j.williams@intel.com,
        jack@suse.cz, ross.zwisler@linux.intel.com, jglisse@redhat.com,
        willy@infradead.org, aarcange@redhat.com, oleg@redhat.com,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org
Content-Transfer-Encoding: 8BIT
Message-Id: <548B6BB8-FD6F-4F8D-B67F-2809305C617D@gmail.com>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <1521736598-12812-3-git-send-email-blackzert@gmail.com>
 <20180322135448.046ada120ecd1ab3dd8f94aa@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3445.5.20)
Return-Path: <blackzert@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63172
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


> On 22 Mar 2018, at 23:54, Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> 
> Please add changelogs.  An explanation of what a "limit on memory
> region random shift" is would be nice ;) Why does it exist, why are we
> doing this, etc.  Surely there's something to be said - at present this
> is just a lump of random code?
> 
> 
> 
Sorry, my bad. The main idea of this limit is to decrease possible memory 
fragmentation. This is not so big problem on 64bit process, but really big for 
32 bit processes since may cause failure memory allocation. To control memory 
fragmentation and protect 32 bit systems (or architectures) this limit was 
introduce by this patch. It could be also moved to CONFIG_ as well.
From blackzert@gmail.com Fri Mar 23 18:55:58 2018
Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2018 18:56:04 +0100 (CET)
Received: from mail-lf0-x242.google.com ([IPv6:2a00:1450:4010:c07::242]:39888
        "EHLO mail-lf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990723AbeCWRz5Oe5wq convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Mar 2018 18:55:57 +0100
Received: by mail-lf0-x242.google.com with SMTP id p142-v6so19522202lfd.6;
        Fri, 23 Mar 2018 10:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Nn/LegfdgCnPMfgxrP8ldElW5x41AbmrS9XnJZIcO0M=;
        b=dmuwuz6Z424tcCQofiCkpe7cXUJw3+yS9d8dSuF6KIrQ3AS98qcM3znkAh+yQ8N861
         DQUFRDwaQ8zsA9zfeG1lYzBYGpXJi8Q50XApUrKoNifIvTjyQXebt0GhEeFeh8udWnN1
         SaV+sgwIzdJcB/Q+xKm4AeFiWecFUaKndxiCasm/VGFuPIpnt4oIuMGZ2lfUg8gMc7EF
         TLbBhWhnBsA501jUsXGVCUu1Ta1OuIi+DgH6N9txRSK0LYwrDOwwO4wBeB3FY9sG34Ee
         y4n5+NevXgWYxnIIpB+Zzgls02Nrk6ePhuN+gOhnMpVoienq2TVmDFk/zgtFS2MEb0+f
         QLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Nn/LegfdgCnPMfgxrP8ldElW5x41AbmrS9XnJZIcO0M=;
        b=laDkW/REk+yWaPTVY+xwYYLiXjC5617gcjtu9hlvqjYrWuiY6/2CWJeq60RJ0zfDcf
         p1pm89/vYwJl4nQ+yw/p2xugnOuYN1oVjS3a8JrIC/snihpSETExvofuUQv+hR4wDbp6
         0S81Iw/KuiGPLHTZohoNxQ/wjCX3nNaL12S/ePCKXlFqnyp7z0mV/2qYLVe22CFxzQwk
         tIcrAuSID8w6m7+5nQNLllsZs/lgi/QYSrkwV+EDjxydCCM+iqAggB1EwPePApZoVw23
         lBnmESc19NwHOdO91s1tye6bM7uzmfXmZZbt//9EwsxoCiOWlv95UnvgjWqHaDbYHPZY
         kDkw==
X-Gm-Message-State: AElRT7FXL7+nRwZt86XOV+lihwpIqTwhVDgvuAUWOX67HKaU7Nc7DJDX
        iSdRLoXARcdlt9CvSFKdABg=
X-Google-Smtp-Source: AG47ELvfGoHwG8ZFUTfHtGgnMEMhX5286YUod0rhOtxN+bKDVeOxka7156ZLffopag3GbBdCfb+X5Q==
X-Received: by 10.46.76.25 with SMTP id z25mr21154931lja.148.1521827752056;
        Fri, 23 Mar 2018 10:55:52 -0700 (PDT)
Received: from [192.168.1.3] (broadband-188-255-70-164.moscow.rt.ru. [188.255.70.164])
        by smtp.gmail.com with ESMTPSA id e8sm851332ljj.6.2018.03.23.10.55.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:55:51 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
From:   Ilya Smith <blackzert@gmail.com>
In-Reply-To: <20180323124806.GA5624@bombadil.infradead.org>
Date:   Fri, 23 Mar 2018 20:55:49 +0300
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
        pombredanne@nexb.com, Andrew Morton <akpm@linux-foundation.org>,
        steve.capper@arm.com, punit.agrawal@arm.com,
        aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
        Kees Cook <keescook@chromium.org>, bhsharma@redhat.com,
        riel@redhat.com, nitin.m.gupta@oracle.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, ross.zwisler@linux.intel.com,
        Jerome Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <651E0DB6-4507-4DA1-AD46-9C26ED9792A8@gmail.com>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180323124806.GA5624@bombadil.infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3445.5.20)
Return-Path: <blackzert@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63173
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
Content-Length: 1135
Lines: 21


> On 23 Mar 2018, at 15:48, Matthew Wilcox <willy@infradead.org> wrote:
> 
> On Thu, Mar 22, 2018 at 07:36:36PM +0300, Ilya Smith wrote:
>> Current implementation doesn't randomize address returned by mmap.
>> All the entropy ends with choosing mmap_base_addr at the process
>> creation. After that mmap build very predictable layout of address
>> space. It allows to bypass ASLR in many cases. This patch make
>> randomization of address on any mmap call.
> 
> Why should this be done in the kernel rather than libc?  libc is perfectly
> capable of specifying random numbers in the first argument of mmap.
Well, there is following reasons:
1. It should be done in any libc implementation, what is not possible IMO;
2. User mode is not that layer which should be responsible for choosing
random address or handling entropy;
3. Memory fragmentation is unpredictable in this case

Off course user mode could use random ‘hint’ address, but kernel may
discard this address if it is occupied for example and allocate just before
closest vma. So this solution doesn’t give that much security like 
randomization address inside kernel.
From dalias@aerifal.cx Fri Mar 23 19:01:15 2018
Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2018 19:01:21 +0100 (CET)
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:48886 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990498AbeCWSBPI4c3q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Mar 2018 19:01:15 +0100
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1ezQzI-0000XQ-00; Fri, 23 Mar 2018 18:00:24 +0000
Date:   Fri, 23 Mar 2018 14:00:24 -0400
From:   Rich Felker <dalias@libc.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ilya Smith <blackzert@gmail.com>, rth@twiddle.net,
        ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com,
        linux@armlinux.org.uk, tony.luck@intel.com, fenghua.yu@intel.com,
        jhogan@kernel.org, ralf@linux-mips.org, jejb@parisc-linux.org,
        deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, ysato@users.sourceforge.jp,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, nyc@holomorphy.com,
        viro@zeniv.linux.org.uk, arnd@arndb.de, gregkh@linuxfoundation.org,
        deepa.kernel@gmail.com, mhocko@suse.com, hughd@google.com,
        kstewart@linuxfoundation.org, pombredanne@nexb.com,
        akpm@linux-foundation.org, steve.capper@arm.com,
        punit.agrawal@arm.com, paul.burton@mips.com,
        aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
        keescook@chromium.org, bhsharma@redhat.com, riel@redhat.com,
        nitin.m.gupta@oracle.com, kirill.shutemov@linux.intel.com,
        dan.j.williams@intel.com, jack@suse.cz,
        ross.zwisler@linux.intel.com, jglisse@redhat.com,
        aarcange@redhat.com, oleg@redhat.com, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
Message-ID: <20180323180024.GB1436@brightrain.aerifal.cx>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180323124806.GA5624@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323124806.GA5624@bombadil.infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dalias@aerifal.cx>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63174
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dalias@libc.org
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
Content-Length: 1289
Lines: 23

On Fri, Mar 23, 2018 at 05:48:06AM -0700, Matthew Wilcox wrote:
> On Thu, Mar 22, 2018 at 07:36:36PM +0300, Ilya Smith wrote:
> > Current implementation doesn't randomize address returned by mmap.
> > All the entropy ends with choosing mmap_base_addr at the process
> > creation. After that mmap build very predictable layout of address
> > space. It allows to bypass ASLR in many cases. This patch make
> > randomization of address on any mmap call.
> 
> Why should this be done in the kernel rather than libc?  libc is perfectly
> capable of specifying random numbers in the first argument of mmap.

Generally libc does not have a view of the current vm maps, and thus
in passing "random numbers", they would have to be uniform across the
whole vm space and thus non-uniform once the kernel rounds up to avoid
existing mappings. Also this would impose requirements that libc be
aware of the kernel's use of the virtual address space and what's
available to userspace -- for example, on 32-bit archs whether 2GB,
3GB, or full 4GB (for 32-bit-user-on-64-bit-kernel) is available, and
on 64-bit archs where fewer than the full 64 bits are actually valid
in addresses, what the actual usable pointer size is. There is
currently no clean way of conveying this information to userspace.

Rich
