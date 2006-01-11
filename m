Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jan 2006 15:11:16 +0000 (GMT)
Received: from wproxy.gmail.com ([64.233.184.203]:3731 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133475AbWAKPKx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jan 2006 15:10:53 +0000
Received: by wproxy.gmail.com with SMTP id 71so176420wri
        for <linux-mips@linux-mips.org>; Wed, 11 Jan 2006 07:14:05 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=InXUtVKzGoETskmJlvDMSxBC3g77aqHnhI5Sno6QiXWUXNaTh5B1ry0nAzSnYPw6yM+C8d4rZsjdtFYEe5l4FfyvehOWPTCBISGhhike8xPdzIHCUnSVbx4N8fjrSeMHXM1IXS0Q4mOU/77ClmM94EmiRdIAbut9O1+UKsb7oO0=
Received: by 10.54.115.5 with SMTP id n5mr940737wrc;
        Wed, 11 Jan 2006 07:14:04 -0800 (PST)
Received: by 10.54.69.5 with HTTP; Wed, 11 Jan 2006 07:14:04 -0800 (PST)
Message-ID: <a59861030601110714n2134ed42w@mail.gmail.com>
Date:	Wed, 11 Jan 2006 16:14:04 +0100
From:	Ivan Korzakow <ivan.korzakow@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: why the early_initcall(au1x00_setup) do not work?
Cc:	"P. Christeas" <p_christ@hol.gr>, linux-mips@linux-mips.org
In-Reply-To: <20060110215322.GA27577@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <50c9a2250601082159p238cacd6r930709da9305479e@mail.gmail.com>
	 <200601101757.45297.p_christ@hol.gr>
	 <a59861030601100838oa89ac84n@mail.gmail.com>
	 <200601101857.26978.p_christ@hol.gr>
	 <20060110215322.GA27577@linux-mips.org>
Return-Path: <ivan.korzakow@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9859
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ivan.korzakow@gmail.com
Precedence: bulk
X-list: linux-mips

2006/1/10, Ralf Baechle <ralf@linux-mips.org>:
> It is possible to keep both Linus's and the lmo tree in the same
> repository with a _little_ care.  I do that all the time.  When compressed
> this will result in a bloat of just about 10-20MB.
>

well, in a MIPS repo:

$ git repack -a -d
$ git prune-packed
$ git prune
$ du .git
266M    .git
$ tree .git/objects/
.git/objects/
|-- info
|   `-- packs
`-- pack
    |-- pack-77ee75692f2944708c9dd65d6ba9100f6647b414.idx
    `-- pack-77ee75692f2944708c9dd65d6ba9100f6647b414.pack

2 directories, 3 files

What kind of magical git commands are you using ?

Ivan
