Received:  by oss.sgi.com id <S42460AbQIGA1n>;
	Wed, 6 Sep 2000 17:27:43 -0700
Received: from u-48.karlsruhe.ipdial.viaginterkom.de ([62.180.20.48]:48132
        "EHLO u-48.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42230AbQIGA1M>; Wed, 6 Sep 2000 17:27:12 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868990AbQIGA0w>;
        Thu, 7 Sep 2000 02:26:52 +0200
Date:   Thu, 7 Sep 2000 02:26:52 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Kanoj Sarcar <kanoj@google.engr.sgi.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: CVS Update@oss.sgi.com: linux
Message-ID: <20000907022651.C20605@bacchus.dhis.org>
References: <20000907020237.B20605@bacchus.dhis.org> <200009070005.RAA27824@google.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200009070005.RAA27824@google.engr.sgi.com>; from kanoj@google.engr.sgi.com on Wed, Sep 06, 2000 at 05:05:18PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Sep 06, 2000 at 05:05:18PM -0700, Kanoj Sarcar wrote:

> > On Wed, Sep 06, 2000 at 04:51:19PM -0700, Kanoj Sarcar wrote:
> > 
> > > The act of flushing the L2 cache, should include flushing the L1
> > > cache, whether done by software or processor provided primitives, 
> > > to guarantee the inclusion principle.
> > 
> > The inclusion principle is not true for all processor types.
> 
> Which processor is supported out of the mips64 tree that does
> not obey the inclusion principle?

The R4600SC and R5000SC IP22.  RM7000 (patches pending) and probably most
future MIPS CPUs.

  Ralf
