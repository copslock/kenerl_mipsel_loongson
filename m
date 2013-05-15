Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 May 2013 17:55:02 +0200 (CEST)
Received: from kymasys.com ([64.62.140.43]:33215 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6824793Ab3EOPy4Q99jO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 May 2013 17:54:56 +0200
Received: from ::ffff:75.40.23.192 ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Wed, 15 May 2013 08:54:45 -0700
Subject: Re: [PATCH 2/2] KVM/MIPS32: Wrap calls to gfn_to_pfn() with srcu_read_lock/unlock()
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From:   Sanjay Lal <sanjayl@kymasys.com>
In-Reply-To: <20130514092705.GD20995@redhat.com>
Date:   Wed, 15 May 2013 08:54:45 -0700
Cc:     kvm@vger.kernel.org, linux-mips@linux-mips.org,
        mtosatti@redhat.com, ralf@linux-mips.org
Content-Transfer-Encoding: 8BIT
Message-Id: <63B7D172-E75E-4AB4-8515-9A18360B66A2@kymasys.com>
References: <n> <1368476500-20031-1-git-send-email-sanjayl@kymasys.com> <1368476500-20031-3-git-send-email-sanjayl@kymasys.com> <20130514092705.GD20995@redhat.com>
To:     Gleb Natapov <gleb@redhat.com>
X-Mailer: Apple Mail (2.1283)
Return-Path: <sanjayl@kymasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36406
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
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


On May 14, 2013, at 2:27 AM, Gleb Natapov wrote:

>> 
>> 
>> +EXPORT_SYMBOL(min_low_pfn);     /* defined by bootmem.c, but not exported by generic code */
>> +
> What you need this for? It is not used anywhere in this patch and by
> mips/kvm code in general.

I did some digging around myself, since the linker keeps complaining that it can't find min_low_pfn when compiling the KVM module.  It seems that it is indirectly pulled in by the cache management functions.


Regards
Sanjay
