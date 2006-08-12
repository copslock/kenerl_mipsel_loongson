Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Aug 2006 03:45:32 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.187]:49944 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20037712AbWHLCpb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 12 Aug 2006 03:45:31 +0100
Received: by nf-out-0910.google.com with SMTP id o60so1234757nfa
        for <linux-mips@linux-mips.org>; Fri, 11 Aug 2006 19:45:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l9dUZ43xHUYzL0Xl68PJs4+yeZBWo17qg9dktd1+X0/rs+eNf2+ifcEP0BBQrYA4VTAyXSBrwMWOReQvFv7HsyQrfTeM1kEffX53s0+cp5yvItSq0S9xUHKy2P4IBVleVB5gOBKFe8BMBN4xP/l3Y4qc3v65RPaAMjQOP1O8vMA=
Received: by 10.78.142.14 with SMTP id p14mr2422448hud;
        Fri, 11 Aug 2006 19:45:28 -0700 (PDT)
Received: by 10.78.118.4 with HTTP; Fri, 11 Aug 2006 19:45:28 -0700 (PDT)
Message-ID: <816d36d30608111945h13272401i31f988064181f099@mail.gmail.com>
Date:	Fri, 11 Aug 2006 22:45:28 -0400
From:	"Ricardo Mendoza" <mendoza.ricardo@gmail.com>
To:	"Daniel Mack" <daniel@caiaq.de>
Subject: Re: [PATCH] Au1200 OHCI/EHCI fixes
Cc:	linux-mips@linux-mips.org
In-Reply-To: <78B291EC-774F-4FDF-AB9D-133F38A3215E@caiaq.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060810065337.GA8889@roarinelk.homelinux.net>
	 <78B291EC-774F-4FDF-AB9D-133F38A3215E@caiaq.de>
Return-Path: <mendoza.ricardo@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mendoza.ricardo@gmail.com
Precedence: bulk
X-list: linux-mips

On 8/10/06, Daniel Mack <daniel@caiaq.de> wrote:

> This has already been fixed - a similar patch went upstream to 2.6.18-
> rc3.
> Did you check out the latest git?

Actually I think a problem stood alive, there is a parent-less #endif
in -rc4 that screwed up compile. I think it has been there since -rc2.

     Ricardo
