Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Apr 2014 23:18:58 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:39287 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6821469AbaDQVS4J5LZb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Apr 2014 23:18:56 +0200
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3HLIj60029746
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 17 Apr 2014 17:18:46 -0400
Received: from sifl.localnet (vpn-61-35.rdu2.redhat.com [10.10.61.35])
        by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id s3HKU9ZX001886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 17 Apr 2014 16:30:10 -0400
From:   Paul Moore <pmoore@redhat.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     libseccomp-discuss@lists.sourceforge.net,
        Andy Lutomirski <luto@amacapital.net>,
        linux-mips@linux-mips.org,
        Markos Chandras <Markos.Chandras@imgtec.com>
Subject: Re: [libseccomp-discuss] [PATCH v3 0/2] Add support for MIPS BE/LE and O32 ABI
Date:   Thu, 17 Apr 2014 16:30:08 -0400
Message-ID: <34948662.6A7a6MXqdE@sifl>
Organization: Red Hat
User-Agent: KMail/4.12.4 (Linux/3.13.9-gentoo; KDE/4.12.4; x86_64; ; )
In-Reply-To: <20140417200715.GA8190@linux-mips.org>
References: <1397550996-14805-1-git-send-email-markos.chandras@imgtec.com> <CALCETrVTptDpPmC_aqL1T10Pm5tTMXJpBLK=osZmc5Vei0bMkA@mail.gmail.com> <20140417200715.GA8190@linux-mips.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Return-Path: <pmoore@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39857
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

On Thursday, April 17, 2014 10:07:15 PM Ralf Baechle wrote:
> On Thu, Apr 17, 2014 at 12:38:36PM -0700, Andy Lutomirski wrote:
> > > For that reason I've long been contemplating to make syscalls of other
> > > ABIs unavailable, even without seccomp.  Would that be useful for
> > > seccomp?
> > 
> > It's still possible to execve something else.
> 
> Would that other process then have a different syscall filter or is there
> only one global one?

Once a seccomp filter is loaded it is inherited by all child processes.

-- 
paul moore
security and virtualization @ redhat
