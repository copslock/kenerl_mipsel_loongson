Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2005 22:28:36 +0100 (BST)
Received: from mail.glaze.se ([IPv6:::ffff:212.209.188.162]:37894 "HELO
	rocket.glaze.se") by linux-mips.org with SMTP id <S8225421AbVITV2R>;
	Tue, 20 Sep 2005 22:28:17 +0100
Received: from IBMJP (unknown [10.42.1.6])
	by rocket.glaze.se (Postfix) with ESMTP
	id 9B33D37646C; Tue, 20 Sep 2005 23:28:15 +0200 (CEST)
From:	"Jan Pedersen" <jan.pedersen@glaze.dk>
To:	"'Jan Pedersen'" <jan.pedersen@glaze.dk>,
	<linux-mips@linux-mips.org>
Subject: RE: kernel panic in cfi
Date:	Tue, 20 Sep 2005 23:28:16 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_002E_01C5BE3A.FAF55590"
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <20050920210204.8AE6537646C@rocket.glaze.se>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcW+Jo3MWUJuk0tiTkq8LQW1898n2gAA2ILA
Message-Id: <20050920212815.9B33D37646C@rocket.glaze.se>
Return-Path: <jan.pedersen@glaze.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9009
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jan.pedersen@glaze.dk
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_002E_01C5BE3A.FAF55590
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Patch attached.

> For any of you who are using flash with the cfi driver, this may be of
> your
> interrest:
> 
> When using the cfi (common flash interface) driver, every word written to
> the flash chips is followed by a operation complete poll. This poll is
> intended to have a timeout of 1 ms. However this timeout is calculated by
> HZ/1000, which happends to be 0 because HZ < 1000. The result of this is
> that there will be just one poll for operation complete. If this single
> poll
> fails, the kernel panics. I have not had the time to investigate this
> panic
> further. Instead, I have made a workaround that increases this timeout to
> HZ
> (1 second). 1 second is far more than needed, but is preferred over a
> panic.
> 
> The patch is available at http://www.jp-embedded.com.


------=_NextPart_000_002E_01C5BE3A.FAF55590
Content-Type: application/octet-stream;
	name="cfi_workaround-jp-2.4.31-1.0.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="cfi_workaround-jp-2.4.31-1.0.tar.gz"

H4sIAAAAAAAAA+xX+2sbRxDOrzq4/2EaaJFiPe5OOjl14uK0SWoT7NIQGigFs7rb0619r+7uWXFD
//d+uytZklPbaZMSCh6w7zXv+WZnlGTidFHLcybrtkoHZ80gGk6G43AQDoMHn4loEuwGMT2YBON4
Ml5f6YoCCoNxGAVRGEUB4WF3PKEH8edy4J5upOSW+o9ev3j2/PjFJ9sIg2A6mdxY/ygej9f1D3dR
/3A3mtKnB3dPd9IboQs+NLRHBDDQOZcVL6hhlUhojQzKakkOGr73rNV5LZdCZ80BUMPLGU9Tng6T
uvS9w7rkUDHnhiHXutkbja4xjXzvFy6VqCunBnjzPd97tWHe9wYb5Htvc15Rq0Q1J51z620Xmsq6
oqxgKidRaS4zlvAepVJccNknjv+XJo6UFlJoDQ26NuK+52SSXDSKhEKARVEveEqzS2JUN1wyDe8I
FpqCa8QDhiG9ycFrbo2MMVghIOj0vZxdcEhqUfK61VRnFFKphnQIrfACRiGx+orbhBVJWzDtTB7+
OkKfBH1a5CLJjbamgW5l3J1xnJAznrBWcTDSUzKsxhdOkqu2sNasfmMiZ9pEKDktBPycIdazVoGn
ckHYWn4Y4JCOlkpMiosVLxOF6tuEO2j4ni0OAjsiG3JVa9yklsWEZzwW1QVXWswRnVPp8JS10jgG
0UppztK+7y2VlCw1ydsAnA1DVInkTHG1nT1YQBq6ISme1FXaG9Lq1vdMKZmkspbGNKuo4hwl6tPM
pb2RPONSIuu1qQpzrg0N+N4K4Lq1ycNbneSEIhTCsFb25QaG6eeYZjWTqJBsq8qAEv5G0wkdH/6B
xGvUsG7gMCuQ4SoT89bYVJKVxEw/WfThOyRdfuEv3GMz40EUD+Lga4CTVXNuist8b6szRUaXdWsx
za1rvNICGpza7jii4+97LigmrXclVwodud1U675aMKENm8EGM5gojZdI9BX+hcvBRttsuk0IpJa+
t3R5BUJ6jjw1EF1CEXgFVJiiXMxzPGeuTPzKommMFSCXrtnSr/vhCokuekUmYYDOdpzbfed7M54z
cYHgoAuOmrIYcytbBZo+05abo671ue0uufIPQkv9vrc04DytMncgLV2XvASqUpv4L320fxTdOv9v
+zi0DfJRNu6a/+NJeG3/m8a4/LeB35OlVGQZDU5YK6kQVftuWeFhLecjN0PVqNTpyPa7BURSporr
UwygaJhsCX2MgDl9/pWlThQEk0EI7O1SMN2LJ3sRULgiGgRxEHg7Ozv/2COjOB4EjwdRRGG0F072
wt0txRMoPjigQRwG/V3acZeDA486AC8OFBwehcJegsl9SULbiYkjgB6NVj9vwJr+PqV9+uH4eTd8
+nTae2JfxetXMV4NOna+4eUZqiJwsu1Qd7kX9J7Q6BFmnLaH9MYcDEtlz+yqXsCit/P3Om4W35Km
Tgd/dZEqzTQi2jdL1qk5srsla/rEUmldv/WzydW3cdAPI9ox18cuWSZbtFZNm9K0Eier3rJe8d3N
iszZq8i61N2w8Q0F74Lg5Uvq0f4+vnz4uoeE3SX61U2iS+vvvQFdo0ZiMzzv0sPl8N2zY1AyobAC
YMHDcoXtC8vcegtbMLNOQrKeY6VTbl1xTKsZldJPr36rHiLwa3H/ieeOeejwQvFtd94bNy0XAGC8
MMM60WgLUjUtoB0rUlpjgMIs13aQKV03bqmw9h0wOh07DszIddU2yA3evQx6fbsNDL5DjqQ2Vbkp
Ha9evD45ffvs9cnRyY/08Mhs6xXmsNsoUn4hEr5en5PELkwAp1tytlOFB+C2vEqn02G+GJ+Rcpco
7/8xhe/pnr4M/QUAAP//AwBkhPzFABQAAA==

------=_NextPart_000_002E_01C5BE3A.FAF55590--
