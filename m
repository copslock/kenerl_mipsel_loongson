Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Aug 2007 12:31:53 +0100 (BST)
Received: from fk-out-0910.google.com ([209.85.128.190]:9998 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20026864AbXHHLbo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 8 Aug 2007 12:31:44 +0100
Received: by fk-out-0910.google.com with SMTP id f40so126644fka
        for <linux-mips@linux-mips.org>; Wed, 08 Aug 2007 04:31:27 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hHjpFnB5ZoCcKTjExnUilzUuga8GHZzB0POINW72oohmRoZ8ePmZXMqGfElx8wI8ZMVAd33ppWto8FbdQJtTxNB9yUMV+FgI8wtRtceXE3zr1WvDN4VlCHESgOUZ6L8hWMvdRVkOpEsClyh+Txl3LVIX2B3AieAnjLvYrowElqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QHzSteNqnVJscun/4diki7kqqHfVO14zmRT8KhO++G6v8KXW/mqAU0RPCdz8dmYn/kkB7w20u7QauIsbPG8m9U5pyyWVUvlOIwn+0aut0QwhiyyM2TdXwBzN4lTAAduqXznlVhVuAgB1NCumkPZyJMNBs2Fw8UeRE6NkN6uJ7EA=
Received: by 10.82.127.14 with SMTP id z14mr1638950buc.1186572686890;
        Wed, 08 Aug 2007 04:31:26 -0700 (PDT)
Received: by 10.82.148.14 with HTTP; Wed, 8 Aug 2007 04:31:26 -0700 (PDT)
Message-ID: <40378e40708080431h56f18f0bjb24d1cc60ed92de1@mail.gmail.com>
Date:	Wed, 8 Aug 2007 13:31:26 +0200
From:	"Mohamed Bamakhrama" <bamakhrama@gmail.com>
Reply-To: bamakhrama@gmail.com
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: Problems with NFS boot
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20070808103119.GB5622@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <40378e40708080318w7dc0f0b7s4c94c98acd72ec2c@mail.gmail.com>
	 <20070808103119.GB5622@linux-mips.org>
Return-Path: <bamakhrama@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16126
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bamakhrama@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,
I added the ":" at the end. It is still not working. I get the same error:

VFS: Cannot open root device "<NULL>" or unknown-block(0,0)
Please append a correct "root=" boot option; here are the available partitions:
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)

Do I have to set any special config. info in the the kernel config
beside the NFS support?



On 8/8/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Wed, Aug 08, 2007 at 12:18:51PM +0200, Mohamed Bamakhrama wrote:
>
> > Hi list,
> > I have a Malta board for which I was able to build the kernel, load it
> > and start it. The problem comes when it tries to boot through the NFS.
> >
> > I start the kernel with the following command:
> > go . nfsroot=192.168.1.1/mnt/danube_rootfs ip=192.168.1.4:192.168.1.1:::
>                         ^^ there should be a `:' following the IP.
>
>  Ralf
>


-- 
Mohamed A. Bamakhrama
Am Schaeferanger 15, room 035
85764 Oberschleissheim, Germany
Email: bamakhra@cs.tum.edu
Web: http://home.cs.tum.edu/~bamakhra/
Mobile: +49-160-9349-2711
