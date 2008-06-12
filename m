Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2008 10:51:50 +0100 (BST)
Received: from wf-out-1314.google.com ([209.85.200.169]:9830 "EHLO
	wf-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S28578203AbYFLJvr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jun 2008 10:51:47 +0100
Received: by wf-out-1314.google.com with SMTP id 28so4327568wff.21
        for <linux-mips@linux-mips.org>; Thu, 12 Jun 2008 02:51:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=F6LGIQl4CuEpYvQniQv8GJhqbhAiN0X56tbvMyGVae0=;
        b=BnK61hr6HKyIPayHGszC/8nPm25oCOs+Q4AeGwZnUGL3LuVxfZAgAdCdC7Xy5LNgfz
         nlvpRQv6oFVlSQESWJ5b2DXC+xpUrPI3U+FJLpMUcolX8A5XI2o+oFI7eVI5Ay3AK0e6
         GVpUcfMaxECfv5C8VzFGE+piYui0dHnHzFnrI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=j1cr9Tatjtdw71sMTNy0wsT00PE5WRZZV58r9e6z8HgAaK6sv/0czwJ67u7ztSqx8b
         BHdlQUHNPeBqx9ZP/dGdtOPLhW9NMZu1XvPtxo59z5u2H9+U6zFKuc3Bv0WGSS4CiRAR
         HbxG/wm5xlI12EQFYwAt5AtI6NA3DC6YZGafU=
Received: by 10.142.174.18 with SMTP id w18mr389646wfe.325.1213264304694;
        Thu, 12 Jun 2008 02:51:44 -0700 (PDT)
Received: by 10.143.42.1 with HTTP; Thu, 12 Jun 2008 02:51:44 -0700 (PDT)
Message-ID: <dcf6addc0806120251t4785dc09tc4a6f0854c5cd425@mail.gmail.com>
Date:	Thu, 12 Jun 2008 17:51:44 +0800
From:	J.Ma <sync.jma@gmail.com>
To:	"Markus Gothe" <markus.gothe@27m.se>
Subject: Re: [SPAM] linux-2.6.25.4 Porting OOPS
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <20B109E2-594E-4329-95C7-F67E9A7882E2@27m.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <dcf6addc0806082001m19d54184pc8ab42b0875c5238@mail.gmail.com>
	 <20B109E2-594E-4329-95C7-F67E9A7882E2@27m.se>
Return-Path: <sync.jma@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19497
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sync.jma@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, Jun 9, 2008 at 1:53 PM, Markus Gothe <markus.gothe@27m.se> wrote:
> Start with checking the memory mapping as hinted by:
> ra    : 8000dd10 copy_user_highpage+0x98/0x158
> //Markus

Thank you for your advice, I checked this function and found that the
problem might be "cpu_has_dc_aliases", After disabling
MIPS_CACHE_ALIASES in probe_pcache(), the linux goes on with no oops.
Could anyone here provide instructions about fusion MIPS SOC(R3K/R4K
for example)? It confused me a lot. :)

-- 
FIXME if it is wrong.
