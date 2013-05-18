Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 May 2013 08:23:45 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:54615 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817667Ab3ERGXojX7Py (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 18 May 2013 08:23:44 +0200
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4I6NZ8m020334
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sat, 18 May 2013 02:23:35 -0400
Received: from dhcp-1-237.tlv.redhat.com (dhcp-4-26.tlv.redhat.com [10.35.4.26])
        by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r4I6NZFo000890;
        Sat, 18 May 2013 02:23:35 -0400
Received: by dhcp-1-237.tlv.redhat.com (Postfix, from userid 13519)
        id D08FD1336CE; Sat, 18 May 2013 09:23:34 +0300 (IDT)
Date:   Sat, 18 May 2013 09:23:34 +0300
From:   Gleb Natapov <gleb@redhat.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Sanjay Lal <sanjayl@kymasys.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, mtosatti@redhat.com
Subject: Re: [PATCH 3/3] KVM/MIPS32: Fix up KVM breakage caused by
 d532f3d26716a39dfd4b88d687bd344fbe77e390 which allows ASID mask and
 increment to be determined @ runtime.
Message-ID: <20130518062334.GB12957@redhat.com>
References: <n>
 <1368825912-23562-1-git-send-email-sanjayl@kymasys.com>
 <1368825912-23562-4-git-send-email-sanjayl@kymasys.com>
 <20130518000636.GC24568@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130518000636.GC24568@linux-mips.org>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Return-Path: <gleb@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gleb@redhat.com
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

On Sat, May 18, 2013 at 02:06:36AM +0200, Ralf Baechle wrote:
> On Fri, May 17, 2013 at 02:25:12PM -0700, Sanjay Lal wrote:
> > Date:   Fri, 17 May 2013 14:25:12 -0700
> > From: Sanjay Lal <sanjayl@kymasys.com>
> > To: kvm@vger.kernel.org
> > Cc: linux-mips@linux-mips.org, ralf@linux-mips.org, gleb@redhat.com,
> >  mtosatti@redhat.com, Sanjay Lal <sanjayl@kymasys.com>
> > Subject: [PATCH 3/3] KVM/MIPS32: Fix up KVM breakage caused by
> >  d532f3d26716a39dfd4b88d687bd344fbe77e390 which allows ASID mask and
> >  increment to be determined @ runtime.
> 
> Good grief, yet another bug report against that patch ...  I've reverted
> d532f3d26 just before your posting.  So I'm going to drop this patch.
> 
Ralf, I am going to take patch 1 and 2 through kvm.git. Can you take
"Export min_low_pfn" through mips tree?

--
			Gleb.
