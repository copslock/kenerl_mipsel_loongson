Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2014 01:17:56 +0200 (CEST)
Received: from mail-we0-f177.google.com ([74.125.82.177]:54900 "EHLO
        mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6855083AbaETXRxCeANx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 May 2014 01:17:53 +0200
Received: by mail-we0-f177.google.com with SMTP id x48so1201577wes.8
        for <linux-mips@linux-mips.org>; Tue, 20 May 2014 16:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :organization:user-agent:in-reply-to:references:mime-version
         :content-type;
        bh=tODtCX5BF+dp4scR5Lgu66S/hsov+KpW4OHFYf9Je+o=;
        b=I4YSJLHV4QyI+LcA8V8A7ZNfK5gMHI4xJQ167nIL94gOB68vtpcWsXFNDKdHjiypfE
         41CUTrwM2ChGULxRqZMsYM8ezMxikl0VeIWsBjFt33V0s1hhhYQq0+b9y69HoEScbYPE
         +LRzrXDPgz4UXsqRRhtzwLtzoxJEFXjEpxgCPMr6ttB/uCEg9lYHMUf9shX1ua7rPvJp
         24RUw7Ideemh526BZkqdWMbUmJlF20tOUIHa+i59wN+JhEFBtADG/8+sJOfhp6FOljyM
         MSUgr6wHV/rkgJpDaxuIWjSlD8weepN//MWFV+cD82v5jfT1zDjd4eZGwMZ2ucVH9D1Q
         BG9g==
X-Gm-Message-State: ALoCoQkHPSEYBi/t+u7O/hdRrG0ABCzTy+UhKN117INCwn1YzKtqRZNxzQjq/VA5SA4P+D7MQR2O
X-Received: by 10.194.103.36 with SMTP id ft4mr12882725wjb.66.1400627867677;
        Tue, 20 May 2014 16:17:47 -0700 (PDT)
Received: from radagast.localnet (jahogan.plus.com. [212.159.75.221])
        by mx.google.com with ESMTPSA id cz8sm20154702wjc.11.2014.05.20.16.17.46
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 20 May 2014 16:17:46 -0700 (PDT)
From:   James Hogan <james.hogan@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, kvm@vger.kernel.org
Subject: Re: [PATCH 14/15] MIPS: paravirt: Update mips_paravirt_defconfig
Date:   Wed, 21 May 2014 00:17:37 +0100
Message-ID: <2583927.Tb84BXCILT@radagast>
Organization: Imagination Technologies
User-Agent: KMail/4.12.5 (Linux/3.15.0-rc5+; KDE/4.12.5; x86_64; ; )
In-Reply-To: <1400597236-11352-15-git-send-email-andreas.herrmann@caviumnetworks.com>
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com> <1400597236-11352-15-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1823607.ktpaCICzFb"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-Path: <james@albanarts.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40197
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips


--nextPart1823607.ktpaCICzFb
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 20 May 2014 16:47:15 Andreas Herrmann wrote:
> Change CPU selection, enable SMP, enable almost all virtio options.

Looks like this should just be squashed into the previous patch if the 
original defconfig was insufficient.

Cheers
James
--nextPart1823607.ktpaCICzFb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJTe+KYAAoJEGwLaZPeOHZ6hvMP/jdOAUjqCFkkMH+KIuxYLbnw
bMlikof7k3xreddD4tmdtQkOt3PJ4hChrgIe5/NPz5GV+GcSHP44xdvHVUIQ8Fla
LkJ9H5OC7Hqu22731onxrYS/0kjr7KIjW6qMRjdNxHAkKOpUzt9Wfmh2v1DcP2Si
bvibqSRyObzXC1noNSPIE6Dg2ldBUOW6Af7gQTh4dYzaQ89T4aZgi0pgyqBgJ1u3
DAdLzFTbPrsL+ja+CCPoNCpdGU8EO8KNZCxOyhiERYdbWGJ8VQF/AgPSG5GlRI/Q
TBfe3grQ/taflcplDYdHWzKQ2nSXT0toiNFczPz+CVvKnlNbI4jGG7J/s4b+eOYe
hckDc5qZg9FooFbyS3uke/04iy0Jdr47uAzXLL6bEnWu7XcQ5mWd86EjvWWRoGPR
aRhdhkbuYQBY3t0t1LEPKbJSJ+5zlYY9pnho6k5CZUbq9mjbmRLKvIQLQUgk1WMz
zJCooIPKAbH/qA8HyVw7uJnduy9lPxO3kNNIjKYbR43GXcVdo+RTP2TMbWnjx0/u
7fe3vJhIH/Gm/Eouly0qQ7nSAelZZdwFNO/V/7luwR7wY9s8WpAZMaiQwYX4AuyI
wyrfDN1RrgkFfqzRLbGAi5AU7ZzM4o+rteO6QNHtGObQLt37Wkr4TRqDigHoH2iC
kxqxoVY4Ni+GFB1wifts
=8/PA
-----END PGP SIGNATURE-----

--nextPart1823607.ktpaCICzFb--
