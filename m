Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 May 2003 08:21:40 +0100 (BST)
Received: from mx2.redhat.com ([IPv6:::ffff:12.150.115.133]:42769 "EHLO
	mx2.redhat.com") by linux-mips.org with ESMTP id <S8225073AbTEIHVh>;
	Fri, 9 May 2003 08:21:37 +0100
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.11.6/8.11.6) with ESMTP id h497AqZ12039;
	Fri, 9 May 2003 03:10:52 -0400
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id h497LKT10309;
	Fri, 9 May 2003 03:21:20 -0400
Received: from [192.168.123.164] (vpn50-8.rdu.redhat.com [172.16.50.8])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id h497LAM10063;
	Fri, 9 May 2003 00:21:19 -0700
Subject: Re: Problem of cross-mipsel-compiler GLIBC-2.3.X
From: Eric Christopher <echristo@redhat.com>
To: smills_ho <smills_ho@coventive.com>
Cc: Linux/MIPS Development <linux-mips@linux-mips.org>, gcc@gcc.gnu.org
In-Reply-To: <000a01c315cf$8171ac70$d017a8c0@pc208>
References: <3EB0B329.9030603@ict.ac.cn>
	 <16048.55936.346808.522687@cuddles.redhat.com> <3EB0DDC6.5080108@ict.ac.cn>
	 <16048.57054.224964.883062@cuddles.redhat.com>
	 <20030501085018.GA1885@greglaptop.attbi.com>
	 <000a01c315cf$8171ac70$d017a8c0@pc208>
Content-Type: text/plain
Organization: 
Message-Id: <1052464867.2485.3.camel@ghostwheel.sfbay.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 May 2003 00:21:07 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <echristo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2313
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: echristo@redhat.com
Precedence: bulk
X-list: linux-mips

On Thu, 2003-05-08 at 19:05, smills_ho wrote:
> Dear All,
>     I want to make a cross-compilered glibc-2.3.x and I get the source from
> ftp.gun.org. GCC version is 3.2.3, binutils is 2.13.2.1. The step is as
> following:
> 
> 1. Try to build binutils
> 2. Try to make static GCC
> 3. Try to make glibc -----> Then it is failed
> 
> Is there anybody know what's going on or somebody had successfully to build
> the crossed glibc-2.3.x?

A host cross host compiler for linux systems is a little more involved
than this :)

However, I don't know where you went wrong since you really didn't
provide much in the way of information as to what you did or where it
failed.

-eric

-- 
Eric Christopher <echristo@redhat.com>
