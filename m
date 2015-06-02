Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2015 00:43:20 +0200 (CEST)
Received: from mail1.windriver.com ([147.11.146.13]:64253 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026906AbbFBWnSmM1ZC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Jun 2015 00:43:18 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.15.1/8.15.1) with ESMTPS id t52Mh5mn015880
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 2 Jun 2015 15:43:06 -0700 (PDT)
Received: from yow-pgortmak-d1 (128.224.56.57) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.224.2; Tue, 2 Jun 2015
 15:43:05 -0700
Received: by yow-pgortmak-d1 (Postfix, from userid 1000)        id AB5A3E1D2E7; Tue,
  2 Jun 2015 18:43:04 -0400 (EDT)
Date:   Tue, 2 Jun 2015 18:43:04 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Paul Bolle <pebolle@tiscali.nl>
CC:     <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH 3/4] mips: make loongsoon serial driver explicitly modular
Message-ID: <20150602224304.GH29898@windriver.com>
References: <1433276168-21550-1-git-send-email-paul.gortmaker@windriver.com>
 <1433276168-21550-4-git-send-email-paul.gortmaker@windriver.com>
 <1433281628.2361.93.camel@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1433281628.2361.93.camel@x220>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47813
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
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

[Re: [PATCH 3/4] mips: make loongsoon serial driver explicitly modular] On 02/06/2015 (Tue 23:47) Paul Bolle wrote:

> On Tue, 2015-06-02 at 16:16 -0400, Paul Gortmaker wrote:
> > +static void __init serial_exit(void)
> 
> s/__init/__exit/

Argh, yes thanks for spotting that copy-n-waste error.  Will fix.

Paul.
--

> 
> > +{
> > +	platform_device_unregister(&uart8250_device);
> > +}
> > +module_exit(serial_exit);
> 
> 
> Paul Bolle
> 
