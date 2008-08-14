Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Aug 2008 08:50:26 +0100 (BST)
Received: from fg-out-1718.google.com ([72.14.220.158]:53126 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S28597398AbYHNHuT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 14 Aug 2008 08:50:19 +0100
Received: by fg-out-1718.google.com with SMTP id d23so287037fga.32
        for <linux-mips@linux-mips.org>; Thu, 14 Aug 2008 00:50:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:reply-to:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:from;
        bh=9AqL2Vjbo4stgKippHqlF717YmH1/GWUvcVqxbULTCo=;
        b=VOwaFmoY3ZhvhVwlksQEKGTFOZ0UqbxeVtTs5YXdMEt9UgggYwwPR7Jxo9o7sb7ji1
         BSaV+7Sld52JGZy3BUxgGnLR+Mh9cbN+WJh2MxuMJe51EaW07aS0qPxlAixYXuKPeLoo
         UbJMtGvtuus4Fvilaj+jF34z6RsqZftOEWqBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=reply-to:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:from;
        b=wUvdESamhb7vZjI9L1wbwAA0SjMY7TCrzu+13QtWd7CzkThz/j7STZZsd2kfww1RgW
         ETozdqzRQjwnnyz/l3gGCfG53X2igzXgm1zh76PC7qqiPst+Byf1PV0I5sPpQhJlBR8X
         mdovBLZomLhrdXqCOJaS2N9LBDY5PKVtWVGos=
Received: by 10.86.59.18 with SMTP id h18mr1562538fga.63.1218700217871;
        Thu, 14 Aug 2008 00:50:17 -0700 (PDT)
Received: from innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTPS id e20sm3608581fga.1.2008.08.14.00.50.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 Aug 2008 00:50:14 -0700 (PDT)
Reply-To: Brian Foster <brian.foster@innova-card.com>
To:	linux-mips@linux-mips.org
Subject: Re: [QUERY]: Website issues
Date:	Thu, 14 Aug 2008 09:50:17 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	daniel.j.laird@nxp.com
References: <1218698940.5012.1.camel@lnx32dtp04>
In-Reply-To: <1218698940.5012.1.camel@lnx32dtp04>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200808140950.17378.brian.foster@innova-card.com>
From:	Brian Foster <blf.ireland@gmail.com>
Return-Path: <blf.ireland@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blf.ireland@gmail.com
Precedence: bulk
X-list: linux-mips

On Thursday 14 August 2008 09:29:00 Daniel Laird wrote:
> I am having issues viewing the linux-mips GIT repository from a web
> browser.  I am sure that this used to work but at the moment all my
> bookmarks are failing:
> http://git.linux-mips.org/ -> An Apache Test Page
> http://git.linux-mips.org/pub/scm/upstream-akpm.git -> Not found
> 
> Etc, is there a problem or have all my bookmarks got messed up?

Daniel,

 http://www.linux-mips.org/git
 lists all the git repos, and seems to be working for me.

cheers!
	-blf-

-- 
“How many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.” |      http://www.stopesso.com
