Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 15:32:00 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:49230 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903761Ab1KUObw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 Nov 2011 15:31:52 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pALEVkZD015368;
        Mon, 21 Nov 2011 14:31:46 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pALEVhGR015357;
        Mon, 21 Nov 2011 14:31:43 GMT
Date:   Mon, 21 Nov 2011 14:31:43 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     =?iso-8859-1?Q?Ren=E9?= Bolldorf <xsecute@googlemail.com>
Cc:     Gabor Juhos <juhosg@openwrt.org>,
        Sergei Shtylyov <sshtylyov@mvista.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v3 3/7] MIPS: ath79: make ath724x_pcibios_init visible
 for external code
Message-ID: <20111121143143.GA13340@linux-mips.org>
References: <1321825151-16053-1-git-send-email-juhosg@openwrt.org>
 <1321825151-16053-4-git-send-email-juhosg@openwrt.org>
 <4ECA25CD.3050902@mvista.com>
 <4ECA3BCD.3050407@openwrt.org>
 <CAEWqx5_Zep8QwS2t32BpygbqXx0exE4kTsH07J=vW2zr7rVO_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEWqx5_Zep8QwS2t32BpygbqXx0exE4kTsH07J=vW2zr7rVO_w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17345

On Mon, Nov 21, 2011 at 02:58:50PM +0100, René Bolldorf wrote:

> The sob tag is only for persons that are involved in the development
> of the patch.
> 
> Acked-by: Rene Bolldorf <xsecute@googlemail.com>

Since the header file in question was taken from a patch that you had
signed off, it would have been acceptable for Gábor to add a SoB line
for you to this patch in addition to his own.

Documentation/SubmittinPatches defines the semantics of SoB as:

 < ------------ snip snap snop ----------- >

        Developer's Certificate of Origin 1.1

        By making a contribution to this project, I certify that:

        (a) The contribution was created in whole or in part by me and I
            have the right to submit it under the open source license
            indicated in the file; or

        (b) The contribution is based upon previous work that, to the best
            of my knowledge, is covered under an appropriate open source
            license and I have the right under that license to submit that
            work with modifications, whether created in whole or in part
            by me, under the same open source license (unless I am
            permitted to submit under a different license), as indicated
            in the file; or

        (c) The contribution was provided directly to me by some other
            person who certified (a), (b) or (c) and I have not modified
            it.

        (d) I understand and agree that this project and the contribution
            are public and that a record of the contribution (including all
            personal information I submit with it, including my sign-off) is
            maintained indefinitely and may be redistributed consistent with
            this project or the open source license(s) involved.

then you just add a line saying

        Signed-off-by: Random J Developer <random@developer.example.org>

 < ------------ snip snap snop ----------- >

I'm normally accept non-trivial patches with just a single SoB line though
I might ask for the original author(s)' SoB in some cases or might just
complain missing SoBs and apply a patch anyway if it's trivial which means
like 10 lines of not quite rocket science content.

  Ralf
