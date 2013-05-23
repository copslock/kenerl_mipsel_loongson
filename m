Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 May 2013 19:09:44 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:4337 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835087Ab3EWRJiOXvL4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 May 2013 19:09:38 +0200
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4NH9Snt017991
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 23 May 2013 13:09:28 -0400
Received: from dhcp-1-237.tlv.redhat.com (dhcp-4-26.tlv.redhat.com [10.35.4.26])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r4NH9SCW004997;
        Thu, 23 May 2013 13:09:28 -0400
Received: by dhcp-1-237.tlv.redhat.com (Postfix, from userid 13519)
        id 842EE18D3DE; Thu, 23 May 2013 20:09:27 +0300 (IDT)
Date:   Thu, 23 May 2013 20:09:27 +0300
From:   Gleb Natapov <gleb@redhat.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, kvm@vger.kernel.org,
        Sanjay Lal <sanjayl@kymasys.com>, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v5 0/6] mips/kvm: Fix ABI for compatibility with 64-bit
 guests.
Message-ID: <20130523170927.GM26157@redhat.com>
References: <1369248236-27237-1-git-send-email-ddaney.cavm@gmail.com>
 <20130523102834.GN4725@redhat.com>
 <519E4A98.7020903@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <519E4A98.7020903@caviumnetworks.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Return-Path: <gleb@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36567
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

On Thu, May 23, 2013 at 09:58:00AM -0700, David Daney wrote:
> On 05/23/2013 03:28 AM, Gleb Natapov wrote:
> >On Wed, May 22, 2013 at 11:43:50AM -0700, David Daney wrote:
> >>From: David Daney <david.daney@cavium.com>
> >>
> >Please regenerate against master. arch/mips/include/asm/kvm.h does not
> >exists any more.
> 
> New patch sent.  I gather from this message, that you want to merge
> this particular set via your tree instead of Ralf's MIPS tree.
> That's fine with me.  However, we were hoping to have these ABI
> fixing patches pushed to Linus before 3.10 releases, so that there
> don't exist kernel versions with the defective ABI.
> 
I do plan to push them to 3.10 that is why I asked to generate them
against master ("next" branch is for next merge window)

> Future patch sets may affect core MIPS architecture files, and
> therefore may not be so amenable to merging via the KVM tree.  We
> will have to figure out how to handle that.
> 
Are you talking about initial MIPS HW vitalization support? Lets see
the patch series. If core changes are to big for for Ralf to ack them
and push through kvm.git then we can push them via MPIS tree.

--
			Gleb.
