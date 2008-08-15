Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Aug 2008 02:43:28 +0100 (BST)
Received: from wr-out-0506.google.com ([64.233.184.234]:23478 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S28596291AbYHOBnV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 15 Aug 2008 02:43:21 +0100
Received: by wr-out-0506.google.com with SMTP id 58so821445wri.8
        for <linux-mips@linux-mips.org>; Thu, 14 Aug 2008 18:43:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=MiwtNa+LrfOrTHLwP7A8dMTeP/wDi1x2+bGC1l7ggM4=;
        b=f+8jEsBrvWTCGNtX4UCJqDDEFWbZ59W3KaV9ZOjkxY9ahmWz/15R33eH0IdeAbMvyd
         bCKLoA0ebZuTxZFhhVDQ+uhWZkNBfSe+mGlnxi/yLjhpY0H8K1Jq+c42B8d6jbqAWOdP
         is85qIl5xDEEsmRQgzPQMvrlgJyIq3X6DdQ2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=sUVlD9ylXuDYtHPiKaEvSov3esGpudnwlN0wiP3fYgGAYFZWUx5SAZ99RN1oyIkQPc
         Ev3yHkmxmHpeSZ/kvBxRpfbHzZOIC4GRUIVtYYo40bE/MgtucqQu3/oN3xXuIeWFroBZ
         tmbe3tkSPs9b0Yx2y7kKM68XkvyDiFMC3+eCE=
Received: by 10.90.55.9 with SMTP id d9mr2809433aga.23.1218764598292;
        Thu, 14 Aug 2008 18:43:18 -0700 (PDT)
Received: by 10.70.90.10 with HTTP; Thu, 14 Aug 2008 18:43:18 -0700 (PDT)
Message-ID: <7d1d9c250808141843g74e4da1cte337b35c11368465@mail.gmail.com>
Date:	Thu, 14 Aug 2008 21:43:18 -0400
From:	"Paul Gortmaker" <paul.gortmaker@gmail.com>
To:	daniel.j.laird@nxp.com
Subject: Re: [QUERY]: Website issues
Cc:	linux-mips@linux-mips.org
In-Reply-To: <1218698940.5012.1.camel@lnx32dtp04>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1218698940.5012.1.camel@lnx32dtp04>
Return-Path: <paul.gortmaker@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, Aug 14, 2008 at 3:29 AM, Daniel Laird <daniel.j.laird@nxp.com> wrote:
> I am having issues viewing the linux-mips GIT repository from a web
> browser.  I am sure that this used to work but at the moment all my
> bookmarks are failing:
> http://git.linux-mips.org/ -> An Apache Test Page
> http://git.linux-mips.org/pub/scm/upstream-akpm.git -> Not found
>
> Etc, is there a problem or have all my bookmarks got messed up?

In addition to what Ralf said, there is also this:

------
  Linux/MIPS on kernel.org

A copy of the Linux/MIPS kernel repository is also maintained on
kernel.org. It is accessible at:

    * http://www.kernel.org/git/?p=linux/kernel/git/ralf/linux.git;a=summary
(gitweb)
    * git://git.kernel.org/pub/scm/linux/kernel/git/ralf/linux.git

Note that while kernel.org has a massive total of 2 gigabit network
bandwidth it is currently very overloaded and due two the staged
server system on kernel.org the copy of the git tree there may lag
anywhere between 15min to over a day behind its linux-mips.org
equivalent.
------

Paul.


>
> Daniel Laird
>
>
>
