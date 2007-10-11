Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Oct 2007 01:49:03 +0100 (BST)
Received: from wx-out-0506.google.com ([66.249.82.238]:30266 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20021373AbXJKAsy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Oct 2007 01:48:54 +0100
Received: by wx-out-0506.google.com with SMTP id h30so378468wxd
        for <linux-mips@linux-mips.org>; Wed, 10 Oct 2007 17:48:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=TsyJmUrjpSlKhbulh0yzMN1aXMmK2mXfuiFPv0UW1XI=;
        b=QpwkQ2fn4xHfrr8w18B5O6GJq+9xdSwAihpjTQ2mGI0dfeJlWjm52FQFT04AwF2J+TZVg88yIS2gFNt+gztNu8xkVQjQJ8P24QnnJT3osYM8ifmb3p3633Ip9pPp3cQAK07LdDpEw3VrESsr863vY1OfAdZaXn8bpqELliVLqUg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=GJMs1eOnEiJWLGChOmSBvpWaRbpHMuJZeUOqebnTHt2qP2WPGcrcrMy+nc+iKzlJpOpvoLE0DY0XtejFXW07Fxa+Bbhq72L8Txjz3PVdPbjth7uGTuiOlBbkv7uzYDHStHUwfmaMEEGlhDRcCJlYuL+UzgC6UlUb+blGFmjPtag=
Received: by 10.70.9.8 with SMTP id 8mr2184552wxi.1192063715932;
        Wed, 10 Oct 2007 17:48:35 -0700 (PDT)
Received: from ?192.168.0.3? ( [87.18.114.61])
        by mx.google.com with ESMTPS id h10sm1796768wxd.2007.10.10.17.48.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Oct 2007 17:48:34 -0700 (PDT)
From:	Matteo Croce <technoboy85@gmail.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH][MIPS][0/6] AR7: AR7 strikes back
Date:	Thu, 11 Oct 2007 02:48:32 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	nico@openwrt.org, nbd@openwrt.org, florian@openwrt.org,
	openwrt-devel@lists.openwrt.org,
	Andrew Morton <akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710110248.33028.technoboy85@gmail.com>
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

Here are the new patches made against latest 2.6.23 git tree
