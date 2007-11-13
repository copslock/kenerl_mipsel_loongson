Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2007 22:12:13 +0000 (GMT)
Received: from nz-out-0506.google.com ([64.233.162.238]:39084 "EHLO
	nz-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20028100AbXKMWMF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Nov 2007 22:12:05 +0000
Received: by nz-out-0506.google.com with SMTP id n1so1236572nzf
        for <linux-mips@linux-mips.org>; Tue, 13 Nov 2007 14:11:54 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=H7MFF3rT44+V61gO2fjZbrQhkn/yBvZlKlGS+vUzaCk=;
        b=Ke7M4ajYj5e/i2aVhbs/tAG33ZnbS1WlcNPIOXGFl3UxKZ/1MuwEO7EbuJ/UIy9ckaCWhDx+vjh3x3b4ILsB0ykvn0nFpUKmRO/wRaylOFbFfoh/6tQcwQ2yLrDRB6fE8urWtVJ9R4ZF6Tf1Fziea9Lxee76aHnFl8pCOOdx73s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ln1Rfla843+jAPBPvblidYRs0hAhpw41PLYgeN6/nfy6019gnswGFS1Vd4KjcM4q2OHyAH7ICdG/s5TXwUlScyux2k1nPkTY000EZGNCdrfdIXOsRVW5cpqy6gIJMMyoPtDdKXIC5suHHL1lZFXWxgvziIAn67ufIgzij3F4rxQ=
Received: by 10.142.76.4 with SMTP id y4mr87074wfa.1194991912549;
        Tue, 13 Nov 2007 14:11:52 -0800 (PST)
Received: by 10.143.4.16 with HTTP; Tue, 13 Nov 2007 14:11:52 -0800 (PST)
Message-ID: <de8d50360711131411r27a56eb1s1234af4c9f102aa2@mail.gmail.com>
Date:	Tue, 13 Nov 2007 14:11:52 -0800
From:	"Andrew Pinski" <pinskia@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: Cannot unwind through MIPS signal frames with ICACHE_REFILLS_WORKAROUND_WAR
Cc:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>,
	"Andrew Haley" <aph-gcc@littlepinkcloud.com>,
	"David Daney" <ddaney@avtrex.com>, linux-mips@linux-mips.org,
	"Richard Sandiford" <rsandifo@nildram.co.uk>, gcc@gcc.gnu.org
In-Reply-To: <20071113150146.GC7650@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <473957B6.3030202@avtrex.com>
	 <18233.36645.232058.964652@zebedee.pink>
	 <20071113121036.GA6582@linux-mips.org>
	 <cda58cb80711130514x16356ea3x4069616c9ee3caac@mail.gmail.com>
	 <20071113140036.GA7650@linux-mips.org>
	 <cda58cb80711130622u7ef77870iae407f7c8054e9da@mail.gmail.com>
	 <20071113150146.GC7650@linux-mips.org>
Return-Path: <pinskia@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pinskia@gmail.com
Precedence: bulk
X-list: linux-mips

On 11/13/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> Old versions of glibc were probable the most notorious users of trampolines.
> Objective C also generates them.  Since a cacheflush that is a syscall is
> required performance is less than great.

No Objective-C does not generate them.  Objective-C returns the exact
function pointer back.  Now libffi generates trampolines.

-- Pinski
