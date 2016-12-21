Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Dec 2016 19:10:06 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:60070 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993352AbcLUSJ7EHb4h (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Dec 2016 19:09:59 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id uBLI9vRn019665;
        Wed, 21 Dec 2016 19:09:57 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id uBLI9uFH019664;
        Wed, 21 Dec 2016 19:09:56 +0100
Date:   Wed, 21 Dec 2016 19:09:56 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     "Steven J. Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 1/5] MIPS: FW: Make fw_init_cmdline() to be __weak.
Message-ID: <20161221180956.GA5561@linux-mips.org>
References: <b14ef49d-f39c-4e13-2da8-ab94804395a2@cavium.com>
 <20161221171015.GA13689@linux-mips.org>
 <892fff47-d83e-fbb5-92a5-248d6e3a3eea@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <892fff47-d83e-fbb5-92a5-248d6e3a3eea@caviumnetworks.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56114
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Wed, Dec 21, 2016 at 10:08:11AM -0800, David Daney wrote:

> On 12/21/2016 09:10 AM, Ralf Baechle wrote:
> > On Tue, Nov 22, 2016 at 01:43:54PM -0600, Steven J. Hill wrote:
> > 
> > > Some bootloaders pass the kernel parameters in different registers.
> > > Allow for platform-specific initialization of the command line.
> > > 
> > > Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
> > > ---
> > >  arch/mips/include/asm/fw/fw.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/mips/include/asm/fw/fw.h b/arch/mips/include/asm/fw/fw.h
> > > index d0ef8b4..0fcd63e 100644
> > > --- a/arch/mips/include/asm/fw/fw.h
> > > +++ b/arch/mips/include/asm/fw/fw.h
> > > @@ -21,7 +21,7 @@
> > >  #define fw_argv(index)		((char *)(long)_fw_argv[(index)])
> > >  #define fw_envp(index)		((char *)(long)_fw_envp[(index)])
> > > 
> > > -extern void fw_init_cmdline(void);
> > > +extern void __weak fw_init_cmdline(void);
> > >  extern char *fw_getcmdline(void);
> > >  extern void fw_meminit(void);
> > >  extern char *fw_getenv(char *name);
> > 
> > Nice try - expect it doesn't work.
> 
> Ralf,  Can you drop this unneeded patch, and still apply the other OCTEON
> KASLR patches in this set?

Already done and pushed a few minutes ago.

  Ralf
