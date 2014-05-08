Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 May 2014 16:11:14 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:29226 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817088AbaEHOLCol6gP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 May 2014 16:11:02 +0200
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s48EAfQ9012306
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 May 2014 10:10:41 -0400
Received: from sifl.localnet (vpn-53-151.rdu2.redhat.com [10.10.53.151])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s48EAeGg011548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 8 May 2014 10:10:41 -0400
From:   Paul Moore <pmoore@redhat.com>
To:     Markos Chandras <Markos.Chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Andy Lutomirski <luto@amacapital.net>,
        Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH 3.15] MIPS: Add new AUDIT_ARCH token for the N32 ABI on MIPS64
Date:   Thu, 08 May 2014 10:10:40 -0400
Message-ID: <6396078.TUTnZW0Rh0@sifl>
Organization: Red Hat
User-Agent: KMail/4.13 (Linux/3.14.1-gentoo; KDE/4.13.0; x86_64; ; )
In-Reply-To: <5360C13A.5040902@imgtec.com>
References: <1397550996-14805-1-git-send-email-markos.chandras@imgtec.com> <2110472.rttbk0K4Ne@sifl> <5360C13A.5040902@imgtec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Return-Path: <pmoore@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40049
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pmoore@redhat.com
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

On Wednesday, April 30, 2014 10:24:10 AM Markos Chandras wrote:
> On 04/24/2014 08:19 PM, Paul Moore wrote:
> > On Tuesday, April 22, 2014 03:40:36 PM Markos Chandras wrote:
> >> A MIPS64 kernel may support ELF files for all 3 MIPS ABIs
> >> (O32, N32, N64). Furthermore, the AUDIT_ARCH_MIPS{,EL}64 token
> >> does not provide enough information about the ABI for the 64-bit
> >> process. As a result of which, userland needs to use complex
> >> seccomp filters to decide whether a syscall belongs to the o32 or n32
> >> or n64 ABI. Therefore, a new arch token for MIPS64/n32 is added so it
> >> can be used by seccomp to explicitely set syscall filters for this ABI.
> >> 
> >> Link: http://sourceforge.net/p/libseccomp/mailman/message/32239040/
> >> Cc: Andy Lutomirski <luto@amacapital.net>
> >> Cc: Eric Paris <eparis@redhat.com>
> >> Cc: Paul Moore <pmoore@redhat.com>
> >> Cc: Ralf Baechle <ralf@linux-mips.org>
> >> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> >> ---
> >> Ralf, can we please have this in 3.15 (Assuming it's ACK'd)?
> >> 
> >> Thanks a lot!
> >> ---
> >> 
> >>  arch/mips/include/asm/syscall.h |  2 ++
> >>  include/uapi/linux/audit.h      | 12 ++++++++++++
> >>  2 files changed, 14 insertions(+)
> > 
> > I'm far from qualified to ACK any MIPS specific patches, but I do want to
> > add my support for this patch.  As Markos states above, without this
> > patch any seccomp BPF code will be more complex than necessary (see x32
> > for an idea) and projects that try to abstract away the arch/ABI specific
> > nature of the BPF seccomp filters will be have to do a lot more work. 
> > Please merge this patch, or something similar, along with the MIPS BPF
> > seccomp filters in 3.15; waiting until 3.16 will be too late.
> > 
> > I also don't want to speak for the audit folks (Eric?), but I think you'll
> > hear that this patch makes life much easier for them as well.
> > 
> > Thanks,
> > -Paul
> 
> Ralf ping? Can we please have this in 3.15 so userspace application get
> the updated token instead of using the AUDIT_ARCH_MIPS{,EL}64 for both
> n32 and n64? It may be harder to change it once 3.15 is released (ABI
> break).

I haven't heard anything on this patch and I don't see it in the tree this 
morning.  Can we please get this into the 3.15 release?  If not, can you 
please explain why so we have something to go on?

This will cause us a lot of pain in userspace if we don't get this patch 
merged.

-- 
paul moore
security and virtualization @ redhat
