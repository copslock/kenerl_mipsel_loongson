Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2006 06:39:01 +0100 (BST)
Received: from web31512.mail.mud.yahoo.com ([68.142.198.141]:41137 "HELO
	web31512.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20027696AbWIZFid (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 26 Sep 2006 06:38:33 +0100
Received: (qmail 84496 invoked by uid 60001); 26 Sep 2006 05:38:26 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=41TQx8wEt3qzRjWyn1mcnth/27h66Ckif32iOTZVJLwo9f4YZUt5mNcFPizJsoYKxXlXUw1IQQjJIAS5RxMMXEC+LtsE6TKr8eq64jQncgoRVeTTCp3iyV7TGbr14xCLNOxIePxCu6I+wTD39zDs8Q+qJe96FGi9YjMnOoOF8Es=  ;
Message-ID: <20060926053826.84494.qmail@web31512.mail.mud.yahoo.com>
Received: from [65.102.5.19] by web31512.mail.mud.yahoo.com via HTTP; Mon, 25 Sep 2006 22:38:26 PDT
Date:	Mon, 25 Sep 2006 22:38:26 -0700 (PDT)
From:	Jonathan Day <imipak@yahoo.com>
Subject: RE: Kernel debugging contd.
To:	Mark E Mason <mark.e.mason@broadcom.com>, linux-mips@linux-mips.org
In-Reply-To: <7E000E7F06B05C49BDBB769ADAF44D07011FD8C2@NT-SJCA-0750.brcm.ad.broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <imipak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12666
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imipak@yahoo.com
Precedence: bulk
X-list: linux-mips

--- Mark E Mason <mark.e.mason@broadcom.com> wrote:
> Ralf will have to answer that one, but I believe it
> was caught up in a
> general housecleaning of the MMU/cache code.

Ah! Can I use that as an excuse for never cleaning my
house? :)

Seriously, I wonder if it might be a good idea to have
code due to be housecleaned (in any significant way)
to have the old behaviour settable in a config flag,
or make a reverse patch available somewhere?

(What I'm trying to think of is a way for developers
to put in the least extra effort but still leave an
escape for people whose boards do really strange
things.)


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
