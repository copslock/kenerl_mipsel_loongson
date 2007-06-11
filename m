Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jun 2007 15:15:45 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.176]:22692 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20024022AbXFKOPn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 11 Jun 2007 15:15:43 +0100
Received: by py-out-1112.google.com with SMTP id f31so2705394pyh
        for <linux-mips@linux-mips.org>; Mon, 11 Jun 2007 07:14:42 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FR4KPOHCkKA1zkFBpVISGr8Fr4a1/WLmmTiIdScMFNd7dyZIQvnLMulqRhIQFRqvR7hKtFPxO2iQU2jK/aXuEYMptpdA1pN2eR1pxEwaWzM/t3spBWxs7ZgmILrqTfIvotZDb65eTokaub3JRATvAhm31EhWZmtYEsBabS+ckcY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WFl+heoKE4rbbPW9AP/kXxDZNoyRpKNSyyPfYu4ditFdwWO34FVWBS9fyNp+nyq52XzQB33aaKiN7LmTs2BlEK0B3hJ5LH1d747XjRsJzJBFuXY4UgouFvqf3yw3RQUlrHKFRz+01+SaL4D4QhF2d1Cwey+L1iiG8pwsm7Xp/dc=
Received: by 10.65.139.9 with SMTP id r9mr9314017qbn.1181571281852;
        Mon, 11 Jun 2007 07:14:41 -0700 (PDT)
Received: by 10.65.204.8 with HTTP; Mon, 11 Jun 2007 07:14:41 -0700 (PDT)
Message-ID: <cda58cb80706110714o14a47616mb3b1055a44380f5c@mail.gmail.com>
Date:	Mon, 11 Jun 2007 16:14:41 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: Remove obsolete board support
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20070611133029.GA6824@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11815673353523-git-send-email-fbuihuu@gmail.com>
	 <20070611133029.GA6824@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15374
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 6/11/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Mon, Jun 11, 2007 at 03:08:52PM +0200, Franck Bui-Huu wrote:
>
> > This patchset finishes to remove deprecated board support.
>
> I de-deprecated the files but only in feature-removal-schedule.txt not
> the wiki ...
>

OK then this patchset is deprecated...
-- 
               Franck
