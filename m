Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9OL3LP04920
	for linux-mips-outgoing; Wed, 24 Oct 2001 14:03:21 -0700
Received: from hell.ascs.muni.cz (hell.ascs.muni.cz [147.251.60.186])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9OL3ID04916
	for <linux-mips@oss.sgi.com>; Wed, 24 Oct 2001 14:03:19 -0700
Received: (from xhejtman@localhost)
	by hell.ascs.muni.cz (8.11.2/8.11.2) id f9OL61R03550;
	Wed, 24 Oct 2001 23:06:01 +0200
Date: Wed, 24 Oct 2001 23:06:01 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: nick@snowman.net
Cc: linux-mips@oss.sgi.com
Subject: Re: Origin 200
Message-ID: <20011024230601.B2045@mail.muni.cz>
References: <20011024224008.A2045@mail.muni.cz> <Pine.LNX.4.21.0110241647490.25602-100000@ns>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0110241647490.25602-100000@ns>; from nick@snowman.net on Wed, Oct 24, 2001 at 04:48:13PM -0400
X-MIME-Autoconverted: from 8bit to quoted-printable by hell.ascs.muni.cz id f9OL61R03550
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f9OL3JD04917
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Oct 24, 2001 at 04:48:13PM -0400, nick@snowman.net wrote:
> I had very similar problems, where does it oops?  I lost access to the origin
> that was haveing problems before tracking it down :(.  Nick

It seems to be at random place. I don't know what correct boot mesages look
like. Few times it freezed after amount memmory message, few times after message
about RT Link socket (or somewhat), sometimes after serial driver initialized.
Once it freezed after scsi driver loaded. I think it has nothing to do with any
driver because the same kernel freez or oops at different place.

Do you have any idea how to track it down?

-- 
Luká¹ Hejtmánek
