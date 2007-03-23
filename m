Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2007 16:13:57 +0000 (GMT)
Received: from wr-out-0506.google.com ([64.233.184.237]:44609 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022409AbXCWQNx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Mar 2007 16:13:53 +0000
Received: by wr-out-0506.google.com with SMTP id i31so999499wra
        for <linux-mips@linux-mips.org>; Fri, 23 Mar 2007 09:12:52 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aRFCd0cQ+S0Y/JbMuSZgUW76Zotfb5dmDOyfa/NdirNQWQSwQwuZp0jaA4+5OjJ/e5sYkZXpm2YxKsMLpk69GgoeuS2CCxXCc07g6wIV0/iPqxZP2BouWOFYnTBAF+70wo/cwvyvGChvVYIWTEXumg91lOtzZ07EViXuPX4xnC0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BiIJ+Do+9FO8uVlxNO9DHYhyvfsxH0TwDyJESe89ChKGvnXQ0gzuwJ9eOzRd4R+vwofro7M6vpJXy1XI/i1rznOQg8W+I+xaPO6vx7jcnkbvMJv0bOIUcO80u5Iu61hsVK5suj2e8JbsDqKM2d5w1WRp7Ytofqb1IMtQtyb3RbI=
Received: by 10.115.54.1 with SMTP id g1mr1249610wak.1174666372009;
        Fri, 23 Mar 2007 09:12:52 -0700 (PDT)
Received: by 10.114.136.11 with HTTP; Fri, 23 Mar 2007 09:12:51 -0700 (PDT)
Message-ID: <cda58cb80703230912x29795fb8x54dd80f524739e5f@mail.gmail.com>
Date:	Fri, 23 Mar 2007 17:12:51 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ravi Pratap" <Ravi.Pratap@hillcrestlabs.com>
Subject: Re: flush_anon_page for MIPS
Cc:	"Ralf Baechle" <ralf@linux-mips.org>,
	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>, miklos@szeredi.hu,
	linux-mips@linux-mips.org
In-Reply-To: <36E4692623C5974BA6661C0B18EE8EDF6CD391@MAILSERV.hcrest.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070323155641.GA31853@linux-mips.org>
	 <36E4692623C5974BA6661C0B18EE8EDF6CD391@MAILSERV.hcrest.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 3/23/07, Ravi Pratap <Ravi.Pratap@hillcrestlabs.com> wrote:
> > From: Ralf Baechle [mailto:ralf@linux-mips.org]
> > What processor does it fail on?
>
> # cat /proc/cpuinfo
> system type             : Sigma Designs TangoX
> processor               : 0
> cpu model               : MIPS 4KEc V6.8

Does this cpu have cache aliasings ?

How is configured the data cache ? Could you show the 'dmesg' output ?
-- 
               Franck
