Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jan 2003 12:55:22 +0000 (GMT)
Received: from [IPv6:::ffff:198.149.18.6] ([IPv6:::ffff:198.149.18.6]:3255
	"EHLO tolkor.sgi.com") by linux-mips.org with ESMTP
	id <S8225229AbTAVMzV>; Wed, 22 Jan 2003 12:55:21 +0000
Received: from ledzep.americas.sgi.com (ledzep.americas.sgi.com [192.48.203.134])
	by tolkor.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with ESMTP id h0MD3Ckq026605;
	Wed, 22 Jan 2003 07:03:12 -0600
Received: from daisy-e236.americas.sgi.com (daisy-e236.americas.sgi.com [128.162.236.214]) by ledzep.americas.sgi.com (SGI-8.9.3/americas-smart-nospam1.1) with ESMTP id GAA51502; Wed, 22 Jan 2003 06:55:13 -0600 (CST)
Received: from taclab54.munich.sgi.com (taclab54.munich.sgi.com [144.253.195.54]) by daisy-e236.americas.sgi.com (SGI-8.9.3/SGI-server-1.8) with ESMTP id GAA03246; Wed, 22 Jan 2003 06:55:11 -0600 (CST)
Received: (from hch@localhost)
	by taclab54.munich.sgi.com (8.11.6/8.11.6) id h0MK9Jn32216;
	Wed, 22 Jan 2003 15:09:19 -0500
Date: Wed, 22 Jan 2003 15:09:19 -0500
From: Christoph Hellwig <hch@sgi.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Christoph Hellwig <hch@sgi.com>,
	Andrew Clausen <clausen@melbourne.sgi.com>,
	linux-mips@linux-mips.org, gnb@melbourne.sgi.com
Subject: Re: debian's mips userland on mips64
Message-ID: <20030122150919.A32202@sgi.com>
References: <20030122073006.GF6262@pureza.melbourne.sgi.com> <20030122124540.A31505@sgi.com> <20030122134506.A12847@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030122134506.A12847@linux-mips.org>; from ralf@linux-mips.org on Wed, Jan 22, 2003 at 01:45:06PM +0100
Return-Path: <hch@taclab54.munich.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@sgi.com
Precedence: bulk
X-list: linux-mips

On Wed, Jan 22, 2003 at 01:45:06PM +0100, Ralf Baechle wrote:
> There is a 32-bit ptrace compatibility syscall already and last I tried
> it was working quite well for strace.

Indeed.  Didn't even check whether mips64 has it already implemented..
