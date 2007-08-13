Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Aug 2007 19:52:06 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.189]:3172 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20023101AbXHMSv5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 13 Aug 2007 19:51:57 +0100
Received: by nf-out-0910.google.com with SMTP id c10so532318nfd
        for <linux-mips@linux-mips.org>; Mon, 13 Aug 2007 11:51:57 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=deLfzBbmi2ci5rk7qRwlhmtfUmphcaTAs1WC6YdyeQYBaRkvkOs5jjPHZ8uoOXc32C9uvWTnoVPtJ8hK576kfqZlAXSg1gPQ762bY/rtRg/TaVg5M/LSNXLMNxiX+8J1S7NI9RJJon3AjiXlzNYCilCJqefz7lFEEudTFjWsGeU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=qAnty6FvMFTbzAw6LKTU+SUu2OVjAJBZN6Jamel+CmmyKhbRe+nASEQeEE2lQoxdqKEiTx+/2zRlQIkphjme58C9gi1/TDNpA8xvOIyU9fBri5cTZoETYOYFHR7LRH7AJ2aardAYk277XSZgIeZRc7pEXTRyL1Bxr2vL3nkQ8Q4=
Received: by 10.78.177.3 with SMTP id z3mr2370079hue.1187031116983;
        Mon, 13 Aug 2007 11:51:56 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id g8sm20741875muf.2007.08.13.11.51.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Aug 2007 11:51:55 -0700 (PDT)
Message-ID: <46C0A83B.2090003@gmail.com>
Date:	Mon, 13 Aug 2007 20:51:39 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Use generic NTP code for all MIPS platforms
References: <S20023068AbXHMO0W/20070813142622Z+9352@ftp.linux-mips.org>	<20070814.003242.59465104.anemo@mba.ocn.ne.jp>	<46C07F36.1070308@gmail.com> <20070814.020229.29578157.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070814.020229.29578157.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16164
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Mon, 13 Aug 2007 17:56:38 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>>> I think there are no point using GENERIC_CMOS_UPDATE for users of the
>>> new-style RTC_CLASS drivers or platforms with no RTC.
>> But how the new-style RTC drivers get updated ?
> 
> IIUC for now there are no kernel-mode NTP syncronization for new style
> RTC drivers.  (Please correct me if I was wrong)
> 

Well a more general question could be how is the RTC class layer
supposed to interact with the kernel ?

Should RTC class layer implement a general service to update/read the
RTC, IOW should it implement {read,update}_persistent_clock() ?

		Franck
