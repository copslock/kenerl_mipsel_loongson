Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Apr 2014 17:14:11 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:13295 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822097AbaDCPOIIczm4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 Apr 2014 17:14:08 +0200
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s33FDe45015142
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 3 Apr 2014 11:13:40 -0400
Received: from madcap2.tricolour.ca (vpn-63-98.rdu2.redhat.com [10.10.63.98])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s33FDaTU008623
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Thu, 3 Apr 2014 11:13:38 -0400
Date:   Thu, 3 Apr 2014 11:13:36 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>, linux-audit@redhat.com,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Eric Paris <eparis@redhat.com>, Steve Grubb <sgrubb@redhat.com>
Subject: Re: [RESEND PATCH 1/2] MIPS syscall auditing patches
Message-ID: <20140403151336.GA24821@madcap2.tricolour.ca>
References: <1396433596-612624-1-git-send-email-manuel.lauss@gmail.com>
 <1396433596-612624-2-git-send-email-manuel.lauss@gmail.com>
 <20140402155519.GA749@madcap2.tricolour.ca>
 <20140403093257.GO17197@linux-mips.org>
 <1396532936.3615.124.camel@i7.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1396532936.3615.124.camel@i7.infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Return-Path: <rgb@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39628
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rgb@redhat.com
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

On 14/04/03, David Woodhouse wrote:
> On Thu, 2014-04-03 at 11:32 +0200, Ralf Baechle wrote:
> The __AUDIT_ARCH_64BIT flag does allow you to distinguish between 32-bit
> and 64-bit system calls on architectures where you can't tell them apart
> by syscall number alone (e.g. S390?). But even that isn't really needed
> on MIPS because the syscall number tells you *everything* you need to
> know, doesn't it?

That hadn't even occured to me.  So, why not use O32, N32 and 64 flags
and just take mod 1000 of the syscall number and use a 64-bit mask?  Or
drop the 3 arch flags and just identify the arch from the syscall number
range alone?

> David Woodhouse                            Open Source Technology Centre

- RGB

--
Richard Guy Briggs <rbriggs@redhat.com>
Senior Software Engineer, Kernel Security, AMER ENG Base Operating Systems, Red Hat
Remote, Ottawa, Canada
Voice: +1.647.777.2635, Internal: (81) 32635, Alt: +1.613.693.0684x3545
