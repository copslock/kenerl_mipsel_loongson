Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Apr 2014 15:59:01 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:62426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816676AbaDCN663OyrG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 Apr 2014 15:58:58 +0200
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s33DwW9i002663
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 3 Apr 2014 09:58:32 -0400
Received: from flatline.rdu.redhat.com (flatline.rdu.redhat.com [10.13.136.20])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s33DwVPS003695;
        Thu, 3 Apr 2014 09:58:31 -0400
Message-ID: <1396533511.24733.28.camel@flatline.rdu.redhat.com>
Subject: Re: [RESEND PATCH 1/2] MIPS syscall auditing patches
From:   Eric Paris <eparis@redhat.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Richard Guy Briggs <rgb@redhat.com>,
        Manuel Lauss <manuel.lauss@gmail.com>, linux-audit@redhat.com,
        Steve Grubb <sgrubb@redhat.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Date:   Thu, 03 Apr 2014 09:58:31 -0400
In-Reply-To: <1396532936.3615.124.camel@i7.infradead.org>
References: <1396433596-612624-1-git-send-email-manuel.lauss@gmail.com>
         <1396433596-612624-2-git-send-email-manuel.lauss@gmail.com>
         <20140402155519.GA749@madcap2.tricolour.ca>
         <20140403093257.GO17197@linux-mips.org>
         <1396532936.3615.124.camel@i7.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Return-Path: <eparis@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39625
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eparis@redhat.com
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

On Thu, 2014-04-03 at 14:48 +0100, David Woodhouse wrote:
> On Thu, 2014-04-03 at 11:32 +0200, Ralf Baechle wrote:
> > 
> > There's probably the odd bitfield or similar where it might matter?  I
> > did dig a bit in the history of the auditing code and found no code
> > that uses __AUDIT_ARCH_LE other than setting that flag.
> > 
> > David - you introduced __AUDIT_ARCH_LE in kernel commit 2fd6f58ba6e
> > "[AUDIT] Don't allow ptrace to fool auditing, log arch of audited
> > syscalls." on April 29 2005.  Do you still recall the purpose of this
> > flag?
> 
> Obviously I remember nothing. But I really can't see the point in the
> little-endian flag. Perhaps it just seemed like a good idea at the time.
> 
> The __AUDIT_ARCH_64BIT flag does allow you to distinguish between 32-bit
> and 64-bit system calls on architectures where you can't tell them apart
> by syscall number alone (e.g. S390?). But even that isn't really needed
> on MIPS because the syscall number tells you *everything* you need to
> know, doesn't it?
> 
> Even if we started supporting little-endian system calls on a big-endian
> kernel, __AUDIT_ARCH_LE would help with interpreting the output, since
> it's never in a bytewise/binary form *anyway*. It would let you filter
> on LE vs. BE system calls I suppose, but I'm not sure if that's a
> required feature.

The only point of these flags is to uniquely identify the arch.  If the
arch has LE and BE, but it doesn't change the API in any way, it doesn't
matter.  Don't worry about it.

Same for the 64BIT flag.  Do what makes sense to identify the arch and
don't worry to much about it.  (sounds to me like MIPS has 3 arches)

-Eric
