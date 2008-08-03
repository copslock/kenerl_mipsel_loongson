Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Aug 2008 14:56:14 +0100 (BST)
Received: from web25805.mail.ukl.yahoo.com ([217.12.10.190]:22355 "HELO
	web25805.mail.ukl.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20026462AbYHCN4G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 3 Aug 2008 14:56:06 +0100
Received: (qmail 35492 invoked by uid 60001); 3 Aug 2008 13:55:58 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.uk;
  h=Received:X-Mailer:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=kza3Sn0Fv/TUKnx/1OD0RVdT3fp7TWbIdNNOk89YvyZVhbjVTGd4ZjxcCvZlz8droIVtxkBsmbnILvmWuAuXlh4HOFohqPDeW2VljIRSBchGKh6M+UGgOD2CPZ7vwqXfNEwqnOJf4qqBHjVrosVq2WxgEc9qTEYW6YAkBGdKb/E=;
Received: from [86.3.223.194] by web25805.mail.ukl.yahoo.com via HTTP; Sun, 03 Aug 2008 13:55:58 GMT
X-Mailer: YahooMailWebService/0.7.218
Date:	Sun, 3 Aug 2008 13:55:58 +0000 (GMT)
From:	Glyn Astill <glynastill@yahoo.co.uk>
Reply-To: glynastill@yahoo.co.uk
Subject: Re: Debian etch on cobalt
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20080803065822.GE5392@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Message-ID: <758145.35434.qm@web25805.mail.ukl.yahoo.com>
Return-Path: <glynastill@yahoo.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20077
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: glynastill@yahoo.co.uk
Precedence: bulk
X-list: linux-mips

Just discovered sarge falls over too, however less frequently. So perhaps it's something else, I'm not sure now.

I've switched the drive out, I actually managed to find the original 20gig unit that came with it.

One thing I observed today is free memory getting rather low whilst compiling, it shows about 187Mb total, and I've watched it go as low as 8mb free.  The only other thing I can think of is it's possibly overheating and falling over.


--- On Sun, 3/8/08, Martin Michlmayr <tbm@cyrius.com> wrote:

> From: Martin Michlmayr <tbm@cyrius.com>
> Subject: Re: Debian etch on cobalt
> To: "Glyn Astill" <glynastill@yahoo.co.uk>
> Cc: linux-mips@linux-mips.org
> Date: Sunday, 3 August, 2008, 7:58 AM
> * Glyn Astill <glynastill@yahoo.co.uk> [2008-08-01
> 10:49]:
> > Sarge seems okay, however I'd rather run etch. Is
> there anything else I can check?
> 
> I'm not sure.
> 
> There used to be a hang connected to DMA and high network
> traffic, but
> this should be fixed in the kernel in etch.
> -- 
> Martin Michlmayr
> http://www.cyrius.com/


      __________________________________________________________
Not happy with your email address?.
Get the one you really want - millions of new email addresses available now at Yahoo! http://uk.docs.yahoo.com/ymail/new.html
