Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4TGDNnC021958
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 29 May 2002 09:13:23 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4TGDNFb021957
	for linux-mips-outgoing; Wed, 29 May 2002 09:13:23 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from t111.niisi.ras.ru (t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4TGDJnC021954
	for <linux-mips@oss.sgi.com>; Wed, 29 May 2002 09:13:20 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id UAA24249
	for <linux-mips@oss.sgi.com>; Wed, 29 May 2002 20:14:55 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id UAA06469 for linux-mips@oss.sgi.com; Wed, 29 May 2002 20:06:43 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id UAA28375 for <linux-mips@oss.sgi.com>; Wed, 29 May 2002 20:11:58 +0400 (MSK)
Message-ID: <3CF56FDF.8090303@niisi.msk.ru>
Date: Wed, 29 May 2002 20:18:39 -0400
From: Alexandr Andreev <andreev@niisi.msk.ru>
Organization: niisi
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.17 i686; en-US; rv:0.9) Gecko/20010507
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Re: 3 questions about linux-2.4.18 and R3000
References: <3CEEBBA9.5070809@niisi.msk.ru> <3CEEAC5F.6010802@mvista.com> <3CF2A17D.6050207@niisi.msk.ru> <3CF3BB4B.504@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Jun Sun wrote:

>
> I would be also interested to know if removing filp condition would 
> solve your problem.  Nobody has explained why this condition is needed 
> for doing COLOUR_ALIGN().
>
Removing of filp condition solves the problem too. So, as I understand, I
need to remove filp condition instead of fix COLOUR_ALIGN(), isn't it?
And what about that patch of local_flush_tlb_page(), will anybody apply it
to CVS?
